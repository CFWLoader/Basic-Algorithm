//
// Created by CFWLoader on 7/31/17.
//

#include "PageRanker.h"

using namespace std;

vector<pair<unsigned long, float>>
PageRanker::pageRank(
        const vector<vector<unsigned long>>& graph,
        unsigned long iterationLimit,
        float prInitVal = 1.0,
        unsigned long topK = graph.size())
{
    vector<pair<unsigned long, float>> pageRankValues(topK);

    unsigned long nodeIdx = 0;

    for(vector<pair<unsigned long, float>>::iterator iter = pageRankValues.begin();
            iter != pageRankValues.end();
            ++iter, ++nodeIdx)
    {
        iter->first = nodeIdx;
        iter->second = prInitVal;
    }

    for(unsigned long iterationCounter = 0;
            iterationCounter < iterationLimit;
            ++iterationCounter)
    {

    }

    return pageRankValues;
}
