/* SOURCES:
 https://www.geeksforgeeks.org/min-heap-in-cpp/
 https://www.geeksforgeeks.org/haversine-formula-to-find-distance-between-two-points-on-a-sphere/
 */

#include <iostream>
#include <vector>
#include <cmath>
#include <stdexcept>

using namespace std;

struct Species { // Basic species struct (temporary)
    string name;
    double latitude;
    double longitude;
    double distance;
};

class MinHeap { // Min Heap class
private:
    vector<Species> heap; // vector of Species

    void heapifyUp(int index) { // Heapify up function
        while (index > 0) {
            int parentIndex = (index - 1) / 2;
            if (heap[parentIndex].distance > heap[index].distance) {
                swap(heap[parentIndex], heap[index]);
                index = parentIndex;
            } else {
                break;
            }
        }
    }

    void heapifyDown(int index) { // Heapify down function
        int size = heap.size();
        while (true) {
            int smallest = index;
            int leftChild = 2 * index + 1;
            int rightChild = 2 * index + 2;

            if (leftChild < size && heap[leftChild].distance < heap[smallest].distance) {
                smallest = leftChild;
            }
            if (rightChild < size && heap[rightChild].distance < heap[smallest].distance) {
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

public:
    void insert(const Species& species) { // Insert a species into the heap
        heap.push_back(species);
        heapifyUp(heap.size() - 1);
    }

    Species extractMin() { // Extract Min using Heapify Down
        if (heap.empty()) {
            throw runtime_error("Heap is empty");
        }
        Species minSpecies = heap[0];
        heap[0] = heap.back();
        heap.pop_back();
        if (!heap.empty()) {
            heapifyDown(0);
        }
        return minSpecies;
    }

    bool isEmpty() const {
        return heap.empty();
    }
};

double calculateDistance(double lat1, double lon1, double lat2, double lon2) { // Calculate distance from two points
    const double R = 6371.0; // Radius of Earth in kilometers
    double dLat = (lat2 - lat1) * M_PI / 180.0;
    double dLon = (lon2 - lon1) * M_PI / 180.0;

    lat1 = lat1 * M_PI / 180.0;
    lat2 = lat2 * M_PI / 180.0;

    double a = sin(dLat/2) * sin(dLat/2) +
               cos(lat1) * cos(lat2) *
               sin(dLon/2) * sin(dLon/2);

    double c = 2 * atan2(sqrt(a), sqrt(1-a));

    return R * c; // Distance in kilometers
}

MinHeap createEndangeredSpeciesHeap(const vector<Species>& species, double userLat, double userLon) {
    MinHeap heap;
    for (const auto& s : species) {
        Species speciesWithDistance = s;
        speciesWithDistance.distance = calculateDistance(userLat, userLon, s.latitude, s.longitude);
        heap.insert(speciesWithDistance);
    }
    return heap;
}

int main() {
    vector<Species> speciesData = {
            {"Florida Panther", 26.8257, -81.5596},
            {"Whooping Crane", 27.3053, -82.2988},
            {"Manatee", 27.5974, -82.5470}
    };

    double userLat = 27.9944; // Example user location (Lakeland, FL)
    double userLon = -81.7603;

    MinHeap minHeap = createEndangeredSpeciesHeap(speciesData, userLat, userLon);

    // Extract and print the closest species
    while (!minHeap.isEmpty()) {
        Species closestSpecies = minHeap.extractMin();
        cout << "Species: " << closestSpecies.name << ", Distance: " << closestSpecies.distance << " km" << endl;
    }

    return 0;
}