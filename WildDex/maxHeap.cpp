//#include "maxHeap.h"
//
////TODO sort by alpabetical
//
//// Private method: Heapify up
//void MaxHeap::heapifyUp(int index) { //string name
//    while (index > 0) {
//        int parentIndex = (index - 1) / 2;
//        if (heap[parentIndex].name > heap[index].name) { // Compare priorities
//            swap(heap[parentIndex], heap[index]);
//            index = parentIndex;
//        } else {
//            break;
//        }
//    }
//}
////change index to be a number made up based on alphabetical priority
//// Private method: Heapify down
//void MaxHeap::heapifyDown(int index) {
//    int size = heap.size();
//    while (true) {
//        int largest = index;
//        int leftChild = 2 * index + 1;
//        int rightChild = 2 * index + 2;
//
//        if (leftChild < size && heap[leftChild].name < heap[largest].name) {
//            largest = leftChild;
//        }
//        if (rightChild < size && heap[rightChild].name < heap[largest].name) {
//            largest = rightChild;
//        }
//
//        if (largest != index) {
//            swap(heap[index], heap[largest]);
//            index = largest;
//        } else {
//            break;
//        }
//    }
//}
//
//// Public method: Insert a Species into the heap
//void MaxHeap::insert(const SpeciesNode& species) {
//    heap.push_back(species);
//    heapifyUp(heap.size() - 1);
//}
//
//// Public method: Extract the Species with the highest count
//SpeciesNode MaxHeap::extractMax() {
//    if (heap.empty()) {
//        throw runtime_error("Heap is empty");
//    }
//    SpeciesNode maxSpecies = heap[0];
//    heap[0] = heap.back();
//    heap.pop_back();
//    if (!heap.empty()) {
//        heapifyDown(0);
//    }
//    return maxSpecies;
//}
//
//// Public method: Check if the heap is empty
//bool MaxHeap::isEmpty() const {
//    return heap.empty();
//}
