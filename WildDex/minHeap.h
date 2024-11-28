#ifndef MINHEAP_H
#define MINHEAP_H

#include <iostream>
#include <vector>
#include <cmath>
#include <stdexcept>

using namespace std;

// Species structure to hold species data
struct Species {
    string name;
    double latitude;
    double longitude;
    double distance;
};

// Min Heap class for Species
class MinHeap {
private:
    vector<Species> heap; // Vector to hold the heap

    void heapifyUp(int index); // Private helper: Heapify up
    void heapifyDown(int index); // Private helper: Heapify down

public:
    void insert(const Species& species); // Insert a species into the heap
    Species extractMin(); // Extract the species with the minimum distance
    bool isEmpty() const; // Check if the heap is empty
};

// Function to calculate distance between two geographical points
double calculateDistance(double lat1, double lon1, double lat2, double lon2);

// Function to create a MinHeap of endangered species sorted by distance
MinHeap createEndangeredSpeciesHeap(const vector<Species>& species, double userLat, double userLon);

#endif // MINHEAP_H
