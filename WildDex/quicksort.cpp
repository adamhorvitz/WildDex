#include <string>
#include <vector>
#include "quicksort.h"

using namespace std;

//reference: https://www.geeksforgeeks.org/quick-sort-algorithm/
int pivotLogic(vector<string>& names, vector<int>& ids, int low, int high) {
    //preset pivot point
    string pivot = names[high];
    int index = low - 1;

    for (int i = low; i <= high - 1; i++) {
        if(names[i] < pivot) {
            index++;
            swap(names[index], names[i]);
            swap(ids[index], ids[i]);
        }
    }
    swap(names[index + 1], names[high]);
    swap(ids[index + 1], ids[high]);
    return index + 1;
}
void quickSort(vector<string>& names, vector<int>& ids, int low, int high) {
    if (low < high) {
        int separation = pivotLogic(names, ids, low, high);

        //recursion for element calls
        quickSort(names, ids, low, separation - 1);
        quickSort(names, ids, separation + 1, high);
    }
}
