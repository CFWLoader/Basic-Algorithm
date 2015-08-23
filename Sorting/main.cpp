#include <iostream>
#include <vector>
#include <random>
#include <ctime>

#include "Sorter.hpp"
#include "Comparator.hpp"

using namespace std;

int testBubbleSorter();

int testInsertSorter();

int testSelectSorter();

int testQuickSorter();

int testMergeSorter();

int testHeapSorter();

int testCountingSorter();

int main() {

    //testSelectSorter();

    //cout << endl;

    return testCountingSorter();
}

int testBubbleSorter()
{
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

int testInsertSorter()
{
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


    Sorter::InsertSorter::sort(intVector.begin(), intVector.end(), Comparator::KeyLess());

    for(int64_t iter : intVector){
        cout << iter << " ";
    }

    cout << endl;

    return 0;
}

int testSelectSorter()
{
    vector<int64_t> intVector;

    default_random_engine engine;

    uniform_int_distribution<int64_t> generator(1, 200);

    for(size_t i = 0; i < 30; ++i)
    {
        intVector.push_back(generator(engine));
    }

    for(int64_t iter : intVector){
        cout << iter << " ";
    }

    cout << endl;


    Sorter::SelectSorter::sort(intVector.begin(), intVector.end(), Comparator::KeyLess());

    for(int64_t iter : intVector){
        cout << iter << " ";
    }

    cout << endl;

    return 0;
}

int testQuickSorter()
{
    vector<int64_t> intVector;

    default_random_engine engine(static_cast<unsigned int>(time(0)));

    uniform_int_distribution<int64_t> generator(1, 200);

    for(size_t i = 0; i < 30; ++i)
    {
        intVector.push_back(generator(engine));
    }

    for(int64_t iter : intVector){
        cout << iter << " ";
    }

    cout << endl;

    Sorter::QuickSorter::sort(intVector.begin(), intVector.end());
    //Sorter::QuickSorter::sort(intVector.begin(), intVector.end(), Comparator::KeyLess());

    for(int64_t iter : intVector){
        cout << iter << " ";
    }

    cout << endl;

    return 0;
}

int testMergeSorter()
{
    vector<int64_t> intVector;

    default_random_engine engine(static_cast<unsigned int>(time(0)));

    uniform_int_distribution<int64_t> generator(1, 200);

    for(size_t i = 0; i < 30; ++i)
    {
        intVector.push_back(generator(engine));
    }

    for(int64_t iter : intVector){
        cout << iter << " ";
    }

    cout << endl;

    Sorter::MergeSorter::sort(intVector.begin(), intVector.end());

    for(int64_t iter : intVector){
        cout << iter << " ";
    }

    cout << endl;

    return 0;
}

int testHeapSorter()
{
    array<int64_t, 30> valueArray;

    default_random_engine engine(static_cast<unsigned int>(time(0)));

    uniform_int_distribution<int64_t> generator(1, 200);

    for(size_t i = 0; i < 30; ++i)
    {
        valueArray[i] = generator(engine);
    }

    for(auto iter : valueArray){
        cout << iter << " ";
    }

    cout << endl;

    Sorter::HeapSorter::sort(valueArray);

    for(auto iter : valueArray){
        cout << iter << " ";
    }

    cout << endl;

    return 0;

}

int testCountingSorter()
{
    array<int64_t, 30> valueArray;

    default_random_engine engine(static_cast<unsigned int>(time(0)));

    uniform_int_distribution<int64_t> generator(0, 20);

    for(size_t i = 0; i < 30; ++i)
    {
        valueArray[i] = generator(engine);
    }

    for(auto iter : valueArray){
        cout << iter << " ";
    }

    cout << endl;

    Sorter::CountingSorter::sort<int64_t, 30, 20>(valueArray);

    for(auto iter : valueArray){
        cout << iter << " ";
    }

    cout << endl;

    return 0;
}