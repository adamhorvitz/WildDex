#include "redListScraper.h"
#include <iostream>

int main() {
    // Replace "your_api_token_here" with the actual API token :)
    const std::string apiToken = "your_api_token_here";

    std::cout << "Starting Red List Scraper Test...\n";

    int result = fetchRedListData(apiToken);

    if (result == 0) {
        std::cout << "\nRed List Scraper executed successfully.\n";
    } else {
        std::cerr << "\nRed List Scraper encountered an error.\n";
    }

    return result;
}
