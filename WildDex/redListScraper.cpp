#include "redListScraper.h"

// Callback function for cURL to handle response data
size_t WriteCallback(void* contents, size_t size, size_t nmemb, std::string* output) {
    size_t totalSize = size * nmemb;
    output->append(static_cast<char*>(contents), totalSize);
    return totalSize;
}

// Function to make HTTP GET requests using cURL
std::string makeRequest(const std::string& url) {
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

// Function to fetch and process species data from the IUCN API
int fetchRedListData(const std::string& apiToken) {
    // Construct API URL with token
    const std::string apiUrl = "https://apiv3.iucnredlist.org/api/v3/species/category/CR?token=" + apiToken;

    std::cout << "Fetching data from IUCN Red List API..." << std::endl;

    // Fetch data
    std::string jsonResponse = makeRequest(apiUrl);
    if (jsonResponse.empty()) {
        std::cerr << "Failed to fetch data from API." << std::endl;
        return 1;
    }

    // Parse JSON response
    json parsedData;
    try {
        parsedData = json::parse(jsonResponse);
    } catch (const json::parse_error& e) {
        std::cerr << "JSON parse error: " << e.what() << std::endl;
        return 1;
    }

    // Check for valid result data
    if (!parsedData.contains("result")) {
        std::cerr << "No species data found in the API response." << std::endl;
        return 1;
    }

    // Create a MaxHeap to store species by count
    MaxHeap speciesHeap;

    for (const auto& species : parsedData["result"]) {
        std::string name = species.value("scientific_name", "Unknown");
        int count = species.value("taxonid", 0); // Use taxonid as a placeholder count

        speciesHeap.insert({name, count});
    }

    // Display species in descending order of count
    std::cout << "\nSpecies ordered by descending count:\n";
    while (!speciesHeap.isEmpty()) {
        Species maxSpecies = speciesHeap.extractMax();
        std::cout << maxSpecies.name << " with ID: " << maxSpecies.count << std::endl;
    }

    return 0;
}
