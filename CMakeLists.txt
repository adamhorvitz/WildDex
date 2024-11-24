cmake_minimum_required(VERSION 3.27)
project(WildDex)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(WildDex
        main.cpp
        maxHeap.cpp
        minHeap.cpp
        redListScraper.cpp)
