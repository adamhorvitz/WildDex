#include "redListScraper.h"
#include <iostream>

int main() {
    // Replace "your_api_token_here" with the actual API token :)
    const std::string apiToken = "9bb4facb6d23f48efbf424bb05c0c1ef1cf6f468393bc745d42179ac4aca5fee";

    std::cout << "Starting Red List Scraper Test...\n";

    int result = fetchRedListData(apiToken);

    if (result == 0) {
        std::cout << "\nRed List Scraper executed successfully.\n";
    } else {
        std::cerr << "\nRed List Scraper encountered an error.\n";
    }

    return result;
}
