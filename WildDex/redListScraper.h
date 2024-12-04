#ifndef REDLIST_SCRAPER_H
#define REDLIST_SCRAPER_H

#include <iostream>
#include <string>
#include <vector>
#include <curl/curl.h>
#include "minHeap.h"
#include "json.hpp"

using namespace std;

// Namespace for nlohmann JSON
using json = nlohmann::json;

// Function to fetch and process species data from the IUCN API
int fetchHeapSort(const std::string& apiToken);

// Function to make HTTP GET requests using cURL
std::string makeRequest(const std::string& url);

// Callback function for cURL to handle API response data
size_t WriteCallback(void* contents, size_t size, size_t nmemb, std::string* output);

// Fetch common names (we aren't using this anymore because the API is bad)
std::string fetchCommonName(const std::string& scientificName, const std::string& apiToken);

// Logic to find the pivot in quick sort
int pivotLogic(vector<string>& names, vector<int>& ids, int low, int high);

// Recursive quick sort function
void quickSort(vector<string>& names, vector<int>& ids, int low, int high);

// Function to fetch using quick sort
int fetchQuickSort(const std::string& apiToken);

#endif // REDLIST_SCRAPER_H
