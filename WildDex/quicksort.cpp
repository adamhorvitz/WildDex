#include "quicksort.h"
#include <algorithm>

using namespace std;

// Partition logic for quicksort (using names)
int SpeciesManager::partition(int low, int high) {
    string pivot = speciesNames[high]; // Pivot based on name
    int i = low - 1;

    for (int j = low; j < high; j++) {
        if (speciesNames[j] < pivot) { // Alphabetical comparison
            i++;
            swap(speciesNames[i], speciesNames[j]);
            swap(speciesIDs[i], speciesIDs[j]);
        }
    }
    swap(speciesNames[i + 1], speciesNames[high]);
    swap(speciesIDs[i + 1], speciesIDs[high]);
    return i + 1;
}

// QuickSort function
void SpeciesManager::quickSort(int low, int high) {
    if (low < high) {
        int pi = partition(low, high);

        // Recursive calls
        quickSort(low, pi - 1);
        quickSort(pi + 1, high);
    }
}

// Function to add species
void SpeciesManager::addSpecies(const string& name, int id) {
    speciesNames.push_back(name);
    speciesIDs.push_back(id);
}

// Function to sort species alphabetically
void SpeciesManager::sortSpecies() {
    quickSort(0, speciesNames.size() - 1);
}

// Function to retrieve and print sorted species
void SpeciesManager::printSortedSpecies() const {
    cout << "\nSorted Critically Endangered Species:\n";
    for (size_t i = 0; i < speciesNames.size(); i++) {
        cout << "Name: " << speciesNames[i] << ", ID: " << speciesIDs[i] << endl;
    }
}
