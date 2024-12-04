#pragma once
#include <vector>
#include <string>

using namespace std;
using StringVector = std::vector<string>;
using IntVector = std::vector<int>;


int pivotLogic(vector<string>& names, vector<int>& ids, int low, int high);
void quickSort(vector<string>& names, vector<int>& ids, int low, int high);
