cmake_minimum_required(VERSION 3.27)
project(WildDex)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(WildDex
        WildDex/main.cpp
        WildDex/maxHeap.cpp
        WildDex/minHeap.cpp
        WildDex/redListScraper.cpp)

find_package(CURL REQUIRED)
target_include_directories(WildDex PRIVATE ${CURL_INCLUDE_DIRS})
target_link_libraries(WildDex PRIVATE ${CURL_LIBRARIES})
