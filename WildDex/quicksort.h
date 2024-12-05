#pragma once

#include <string>
#include <vector>
#include <iostream>

class SpeciesManager {
private:
    // Private vectors to store species names and IDs
    std::vector<std::string> speciesNames;
    std::vector<int> speciesIDs;

    // Partition logic for quicksort (using names)
    int partition(int low, int high);

    // QuickSort function
    void quickSort(int low, int high);

public:
    // Function to add species
    void addSpecies(const std::string& name, int id);

    // Function to sort species alphabetically
    void sortSpecies();

    // Function to retrieve and print sorted species
    void printSortedSpecies() const;
};

