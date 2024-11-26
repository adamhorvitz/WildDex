cmake_minimum_required(VERSION 3.27)
project(WildDex)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(WildDex
        WildDex/main.cpp
        WildDex/maxHeap.cpp
        WildDex/minHeap.cpp
        WildDex/redListScraper.cpp)
