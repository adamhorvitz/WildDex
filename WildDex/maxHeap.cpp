#include "MaxHeap.h"

// Private method: Heapify up
void MaxHeap::heapifyUp(int index) {
    while (index > 0) {
        int parentIndex = (index - 1) / 2;
        if (heap[parentIndex].count < heap[index].count) { // Compare priorities
            swap(heap[parentIndex], heap[index]);
            index = parentIndex;
        } else {
            break;
        }
    }
}

// Private method: Heapify down
void MaxHeap::heapifyDown(int index) {
    int size = heap.size();
    while (true) {
        int largest = index;
        int leftChild = 2 * index + 1;
        int rightChild = 2 * index + 2;

        if (leftChild < size && heap[leftChild].count > heap[largest].count) {
            largest = leftChild;
        }
        if (rightChild < size && heap[rightChild].count > heap[largest].count) {
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

// Public method: Insert a Species into the heap
void MaxHeap::insert(const SpeciesNode& species) {
    heap.push_back(species);
    heapifyUp(heap.size() - 1);
}

// Public method: Extract the Species with the highest count
SpeciesNode MaxHeap::extractMax() {
    if (heap.empty()) {
        throw runtime_error("Heap is empty");
    }
    SpeciesNode maxSpecies = heap[0];
    heap[0] = heap.back();
    heap.pop_back();
    if (!heap.empty()) {
        heapifyDown(0);
    }
    return maxSpecies;
}

// Public method: Check if the heap is empty
bool MaxHeap::isEmpty() const {
    return heap.empty();
}
