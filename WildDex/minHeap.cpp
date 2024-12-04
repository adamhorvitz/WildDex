/* SOURCES:
 https://www.geeksforgeeks.org/min-heap-in-cpp/
 https://www.geeksforgeeks.org/haversine-formula-to-find-distance-between-two-points-on-a-sphere/
 */

#include "minHeap.h"

// Private method: Heapify up
void MinHeap::heapifyUp(int index) {
    while (index > 0) {
        int parentIndex = (index - 1) / 2;
        if (heap[parentIndex].name > heap[index].name) {
            swap(heap[parentIndex], heap[index]);
            index = parentIndex;
        } else {
            break;
        }
    }
}

// Private method: Heapify down
void MinHeap::heapifyDown(int index) {
    int size = heap.size();
    while (true) {
        int smallest = index;
        int leftChild = 2 * index + 1;
        int rightChild = 2 * index + 2;

        if (leftChild < size && heap[leftChild].name < heap[smallest].name) {
            smallest = leftChild;
        }
        if (rightChild < size && heap[rightChild].name < heap[smallest].name) {
            smallest = rightChild;
        }

        if (smallest != index) {
            swap(heap[index], heap[smallest]);
            index = smallest;
        } else {
            break;
        }
    }
}

// Public method: Insert a species into the heap
void MinHeap::insert(const SpeciesNode& species) {
    heap.push_back(species);
    heapifyUp(heap.size() - 1);
}

// Public method: Extract the species with the minimum distance
SpeciesNode MinHeap::extractMin() {
    if (heap.empty()) {
        throw runtime_error("Heap is empty");
    }
    SpeciesNode minSpecies = heap[0];
    heap[0] = heap.back();
    heap.pop_back();
    if (!heap.empty()) {
        heapifyDown(0);
    }
    return minSpecies;
}

// Public method: Check if the heap is empty
bool MinHeap::isEmpty() const {
    return heap.empty();
}

// Function to calculate distance between two geographical points
/*
double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371.0; // Radius of Earth in kilometers
    double dLat = (lat2 - lat1) * M_PI / 180.0;
    double dLon = (lon2 - lon1) * M_PI / 180.0;

    lat1 = lat1 * M_PI / 180.0;
    lat2 = lat2 * M_PI / 180.0;

    double a = sin(dLat / 2) * sin(dLat / 2) +
               cos(lat1) * cos(lat2) *
               sin(dLon / 2) * sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c; // Distance in kilometers
}
*/

// Function to create a MinHeap of endangered species sorted by distance
/*
MinHeap createEndangeredSpeciesHeap(const vector<SpeciesNode>& species, double userLat, double userLon) {
    MinHeap heap;
    for (const auto& s : species) {
        SpeciesNode speciesWithDistance = s;
        speciesWithDistance.distance = calculateDistance(userLat, userLon, s.latitude, s.longitude);
        heap.insert(speciesWithDistance);
    }
    return heap;
}

*/
