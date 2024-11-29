#ifndef MAXHEAP_H
#define MAXHEAP_H

#include <iostream>
#include <vector>
#include <stdexcept>
#include <string>

using namespace std;

struct SpeciesNode { // Species struct (may not need this?)
    string name;
    int count;

    bool operator<(const SpeciesNode& other) const {
        return count < other.count;
    }
};

// Max Heap class
class MaxHeap {
private:
    vector<SpeciesNode> heap; // Vector of Species

    void heapifyUp(int index); // Heapify up function
    void heapifyDown(int index); // Heapify down function

public:
    void insert(const SpeciesNode& species); // Insert a Species into the heap
    SpeciesNode extractMax(); // Extract the Species with the highest count
    bool isEmpty() const; // Check if the heap is empty
};

#endif
