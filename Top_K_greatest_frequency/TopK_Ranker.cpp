//
// Created by CFWLoader on 5/25/17.
//

#include "TopK_Ranker.h"
#include <algorithm>

using std::string;

TopK_Ranker::TopK_Ranker():
        heapSize(0),
        minHeap(NULL)
{}

TopK_Ranker::TopK_Ranker(std::string filePath, uint k) :
        input(filePath),
        heapSize(k + 1),
        minHeap(new uint[k + 1])
{
    for(uint i = 0; i < heapSize; ++i)
    {
        minHeap[i] = 0;
    }
}

TopK_Ranker::~TopK_Ranker()
{
    delete[] minHeap;
}

std::vector<uint> TopK_Ranker::topKMaximumNumbers()
{
    uint dataValue = 0;

    while(!input.eof())
    {
        dataValue = this->nextValue();

        if(dataValue > this->peekHeap())
        {
            this->updateHeap(dataValue);
        }

    }

    std::vector<uint> result;

    for (uint i = 1; i < heapSize; ++i)
    {
        result.push_back(minHeap[i]);
    }

    std::sort(result.begin(), result.end());

    return result;
}

uint TopK_Ranker::nextValue()
{
    if(input.eof())
    {
        throw "The input is empty!";
    }

    string buf;

    input >> buf;

    return (uint) strtol(buf.c_str(), NULL, 10);
}

uint TopK_Ranker::peekHeap()
{
    return minHeap[1];
}

int TopK_Ranker::updateHeap(uint value)
{
    minHeap[0] = minHeap[1];

    uint idx = 1, l, r;

    while(2 * idx < heapSize && minHeap[idx] < value)
    {
        l = 2 * idx;

        r = 2 * idx + 1;

        if(r >= heapSize) {r = heapSize - 1;}

        if(minHeap[l] < minHeap[r])
        {
            minHeap[idx] = minHeap[l];

            idx = l;
        }
        else
        {
            minHeap[idx] = minHeap[r];

            idx = r;
        }
    }

    if(minHeap[idx] < value)
    {
        minHeap[idx] = value;
    }
    else
    {
        minHeap[idx / 2] = value;
    }

    return 0;
}
