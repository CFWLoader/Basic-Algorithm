//
// Created by CFWLoader on 5/25/17.
//

#ifndef TOP_K_GREATEST_FREQUENCY_TOPK_RANKER_H
#define TOP_K_GREATEST_FREQUENCY_TOPK_RANKER_H

#include <string>
#include <fstream>
#include <vector>
#include <map>

class TopK_Ranker {

public:

    TopK_Ranker();

    TopK_Ranker(std::string filePath, uint k);

    ~TopK_Ranker();

    std::vector<uint> topKMaximumNumbers();

    std::map<uint, uint> topKFrequentestNumbers();

private:

    uint nextValue();

    uint peekHeap();

    int updateHeap(uint value);

    std::ifstream input;

    uint heapSize;

    uint* minHeap;

};


#endif //TOP_K_GREATEST_FREQUENCY_TOPK_RANKER_H
