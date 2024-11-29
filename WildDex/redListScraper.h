#ifndef REDLIST_SCRAPER_H
#define REDLIST_SCRAPER_H

#include <iostream>
#include <string>
#include <vector>
#include <curl/curl.h>
#include "maxHeap.h"
#include "json.hpp"

// Namespace for nlohmann JSON
using json = nlohmann::json;

// Function to fetch and process species data from the IUCN API
int fetchRedListData(const std::string& apiToken);

// Function to make HTTP GET requests using cURL
std::string makeRequest(const std::string& url);

// Callback function for cURL to handle API response data
size_t WriteCallback(void* contents, size_t size, size_t nmemb, std::string* output);

std::string fetchCommonName(const std::string& scientificName, const std::string& apiToken);

#endif // REDLIST_SCRAPER_H
