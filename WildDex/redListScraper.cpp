#include "redListScraper.h"

// Callback function for cURL to handle response data
size_t WriteCallback(void* contents, size_t size, size_t nmemb, std::string* output) {
    size_t totalSize = size * nmemb;
    output->append(static_cast<char*>(contents), totalSize);
    return totalSize;
}

// Function to make HTTP GET requests using cURL
std::string makeRequest(const std::string& url) {/
    CURL* curl;
    CURLcode res;
    std::string response;

    curl = curl_easy_init();
    if (curl) {
        curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &response);
        res = curl_easy_perform(curl);
        if (res != CURLE_OK) {
            std::cerr << "cURL error: " << curl_easy_strerror(res) << std::endl;
        }
        curl_easy_cleanup(curl);
    }
    return response;
}

int fetchRedListData(const std::string& apiToken) {
    const std::string apiUrl = "https://apiv3.iucnredlist.org/api/v3/country/getspecies/US?token=" + apiToken;

    std::cout << "Fetching data from IUCN Red List API..." << std::endl;

    std::string jsonResponse = makeRequest(apiUrl);
    if (jsonResponse.empty()) {
        std::cerr << "Failed to fetch data from API." << std::endl;
        return 1;
    }

    // parse JSON response
    json parsedData;
    try {
        parsedData = json::parse(jsonResponse);
    } catch (const json::parse_error& e) {
        std::cerr << "JSON parse error: " << e.what() << std::endl;
        return 1;
    }

    // check for valid result data
    if (!parsedData.contains("result")) {
        std::cerr << "No species data found in the API response." << std::endl;
        return 1;
    }

    MaxHeap speciesHeap;

    for (const auto& species : parsedData["result"]) {
        std::string scientificName = species.value("scientific_name", "Unknown");
        std::string category = species.value("category", "");

        // critically endangered species only
        if (category == "CR") {
            // fetch the common name using a separate API request
            std::string commonName = fetchCommonName(scientificName, apiToken);
            int count = species.value("taxonid", 0); // Use taxonid as a placeholder count

            speciesHeap.insert({commonName, count});
        }
    }

    // display species in heap as descending order of count
    std::cout << "\nCritically Endangered Species in the United States ordered by descending count:\n";
    while (!speciesHeap.isEmpty()) {
        SpeciesNode maxSpecies = speciesHeap.extractMax();
        std::cout << maxSpecies.name << " with ID: " << maxSpecies.count << std::endl;
    }

    return 0;
}

// helper function to fetch common name for a species (DOES NOT WORK RIGHT NOW)
std::string fetchCommonName(const std::string& scientificName, const std::string& apiToken) {
    const std::string apiUrl = "https://apiv3.iucnredlist.org/api/v3/species/common_names/" + scientificName + "?token=" + apiToken;

    // fetch data
    std::string jsonResponse = makeRequest(apiUrl);
    if (jsonResponse.empty()) {
        std::cerr << "Failed to fetch common name for: " << scientificName << std::endl;
        return "Unknown";
    }

    json parsedData;
    try {
        parsedData = json::parse(jsonResponse);
    } catch (const json::parse_error& e) {
        std::cerr << "JSON parse error while fetching common name for: " << scientificName << ". Error: " << e.what() << std::endl;
        return "Unknown";
    }

    // extract primary common name
    if (parsedData.contains("result")) {
        for (const auto& nameData : parsedData["result"]) {
            if (nameData.value("primary", false)) { 
                return nameData.value("name", "Unknown");
            }
        }
    }

    return "Unknown";
}
