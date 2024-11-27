#include <iostream>
#include <string>
#include <curl/curl.h>
#include <vector>
#include "maxHeap.cpp"
#include "json.hpp"

// CITATION: IUCN 2024. IUCN Red List of Threatened Species. Version 2024-2 <www.iucnredlist.org>

// For convenience :)
using json = nlohmann::json;
using namespace std;

// Callback function for cURL (taken from Google)
size_t WriteCallback(void* contents, size_t size, size_t nmemb, string* output) {
    size_t totalSize = size * nmemb;
    output->append((char*)contents, totalSize);
    return totalSize;
}

// Function to make GET requests (also taken from Google lol)
string makeRequest(const string& url) {
    CURL* curl;
    CURLcode res;
    string response;

    curl = curl_easy_init();
    if (curl) {
        curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &response);
        res = curl_easy_perform(curl);
        curl_easy_cleanup(curl);
        if (res != CURLE_OK) {
            cerr << "cURL error: " << curl_easy_strerror(res) << endl;
        }
    }
    return response;
}

int apifetch() {
    // DO NOT COMMIT THIS
    const string apiToken = "placeholder";

    // API endpoint to list species (NOT WORKING WITH V4)
    const string apiUrl = "https://apiv3.iucnredlist.org/api/v3/species/category/CR?token=" + apiToken;

    cout << "Fetching data from IUCN Red List API..." << endl;

    // Fetch data
    string jsonResponse = makeRequest(apiUrl);
    if (jsonResponse.empty()) {
        cerr << "Failed to fetch data from API." << endl;
        return 1;
    }
    // Parse JSON
    json parsedData = json::parse(jsonResponse);

    if (!parsedData.contains("result")) {
        cerr << "No species data found in the API response." << endl;
        return 1;
    }

    MaxHeap speciesHeap;

    for (const auto& species : parsedData["result"]) {
        string name = species["scientific_name"].get<string>();
        int count = species["taxonid"].get<int>();

        speciesHeap.insert({name, count});
//        cout << "Inserted: " << name << " with count: " << count << endl;
    }

    cout << "\nSpecies ordered by descending count:\n";
    while (!speciesHeap.isEmpty()) {
        Species maxSpecies = speciesHeap.extractMax();
        cout << maxSpecies.name << " with ID: " << maxSpecies.count << endl;
    }

    return 0;
}
