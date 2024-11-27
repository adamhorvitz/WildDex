//
// Created by Adam Horvitz on 11/24/24.
//
#include <iostream>
#include "maxHeap.cpp"
#include "minHeap.cpp"
#include <vector>
#include <cstdlib>
#include <ctime>
using namespace std;

// Testing max heap functionality with random
//int main() {
//    srand(static_cast<unsigned>(time(0))); // Seed random number generator
//
//
//    MaxHeap maxTest;
//    for (int i = 1; i <= 50; ++i) {
//        Species s;
//        s.name = "Species " + to_string(i);
//        s.priority = rand() % 100 + 1;
//        maxTest.insert(s);
//    }
//
//    while (!maxTest.isEmpty()) {
//        Species max = maxTest.extractMax();
//        cout << "Extracted: " << max.name << " with priority " << max.priority << endl;
//    }
//
//    return 0;
//}