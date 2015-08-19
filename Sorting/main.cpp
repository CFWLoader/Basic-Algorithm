#include <iostream>
#include <vector>
#include <random>

#include "Sorter.hpp"
#include "Comparator.hpp"

using namespace std;

int main() {

    vector<int64_t> intVector;

    default_random_engine engine;

    uniform_int_distribution<int64_t> generator(1, 50);

    for(size_t i = 0; i < 20; ++i)
    {
        intVector.push_back(generator(engine));
    }

    for(int64_t iter : intVector){
        cout << iter << " ";
    }

    cout << endl;

    Comparator::KeyLarger keyLarger;

    Sorter::BubbleSorter::sort(intVector.begin(), intVector.end(), keyLarger);

    for(int64_t iter : intVector){
        cout << iter << " ";
    }

    cout << endl;

    return 0;
}