/* SOURCES:
 https://www.geeksforgeeks.org/max-heap-in-cpp/
 https://stackoverflow.com/questions/10575766/comparison-operator-overloading
 */

#include <iostream>
#include <vector>
#include <stdexcept>
#include <string>

using namespace std;

struct Species { // Structure for Species
    string name;
    int priority;

    // Overload < operator for easier comparison
    bool operator<(const Species& other) const {
        return priority < other.priority;
    }
};

class MaxHeap { // Max Heap class
private:
    vector<Species> heap; // Vector of Species

    void heapifyUp(int index) { // Heapify up function
        while (index > 0) {
            int parentIndex = (index - 1) / 2;
            if (heap[parentIndex].priority < heap[index].priority) { // Compare priorities
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
            int largest = index;
            int leftChild = 2 * index + 1;
            int rightChild = 2 * index + 2;

            if (leftChild < size && heap[leftChild].priority > heap[largest].priority) {
                largest = leftChild;
            }
            if (rightChild < size && heap[rightChild].priority > heap[largest].priority) {
                largest = rightChild;
            }

            if (largest != index) {
                swap(heap[index], heap[largest]);
                index = largest;
            } else {
                break;
            }
        }
    }

public:
    void insert(const Species& species) { // Insert a Species into the heap
        heap.push_back(species);
        heapifyUp(heap.size() - 1);
    }

    Species extractMax() { // Extract the Species with the highest priority
        if (heap.empty()) {
            throw runtime_error("Heap is empty");
        }
        Species maxSpecies = heap[0];
        heap[0] = heap.back();
        heap.pop_back();
        if (!heap.empty()) {
            heapifyDown(0);
        }
        return maxSpecies;
    }

    bool isEmpty() const {
        return heap.empty();
    }
};
