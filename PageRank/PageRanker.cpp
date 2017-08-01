//
// Created by CFWLoader on 7/31/17.
//

#include <tuple>
#include <algorithm>
#include "PageRanker.h"

using namespace std;

vector<pair<unsigned long, float>>
PageRanker::pageRank(
        const vector<vector<unsigned long>> &graph,
        unsigned long iterationLimit,
        unsigned long topK,
        float prInitVal,
        float dampingFactor
)
{
    vector<pair<unsigned long, float>> pageRankValues(topK);

    vector<tuple<unsigned long, float, float, size_t>> prProcValues(graph.size());

    unsigned long nodeIdx = 0;

    for (vector<tuple<unsigned long, float, float, size_t>>::iterator iter = prProcValues.begin();
         iter != prProcValues.end();
         ++iter, ++nodeIdx)
    {
        get<0>(*iter) = nodeIdx;
        get<2>(*iter) = prInitVal;

        size_t outDegreeCounter = 0;

        for(vector<unsigned long>::const_iterator graphEleIter = graph[nodeIdx].begin();
                graphEleIter != graph[nodeIdx].end();
                ++graphEleIter)
        {
            outDegreeCounter += *graphEleIter;
        }

        get<3>(*iter) = outDegreeCounter;
    }

    vector<tuple<unsigned long, float, float, size_t>>::iterator prProcValIter;

    // Applying the page rank algorithm.
    for (unsigned long iterationCounter = 0;
         iterationCounter < iterationLimit;
         ++iterationCounter)
    {
        for (prProcValIter = prProcValues.begin();
             prProcValIter != prProcValues.end();
             ++prProcValIter)
        {
            get<1>(*prProcValIter) = get<2>(*prProcValIter);
            // get<2>(*prProcValIter) = 1.0 - dampingFactor;
            get<2>(*prProcValIter) = 0;
        }

//        for (vector<vector<unsigned long>>::const_iterator rowIter = graph.begin();
//             rowIter != graph.end();
//             ++rowIter)
//        {
//            for (vector<unsigned long>::const_iterator colIter = rowIter->begin(),
//                         prProcValIter = prProcValues.begin();
//                 colIter != rowIter->end();
//                 ++prProcValIter, ++colIter)
//            {
//                if (*colIter == 1)
//                {
//
//                }
//            }
//        }
        for(unsigned long rowIdx = 0; rowIdx < graph.size(); ++rowIdx)
        {
            for(unsigned long colIdx = 0; colIdx < graph[rowIdx].size(); ++colIdx)
            {
                if(graph[rowIdx][colIdx] == 1)
                {
                    get<2>(prProcValues[colIdx]) += get<1>(prProcValues[rowIdx]) / get<3>(prProcValues[rowIdx]);
                }
            }
        }
    }

    // Ranking by page rank values.
    sort(prProcValues.begin(), prProcValues.end(), [](tuple<unsigned long, float, float, size_t> a,
                                                      tuple<unsigned long, float, float, size_t> b)
         {
             if (get<2>(a) < get<2>(b))return -1;
             else if (get<2>(a) == get<2>(b))return 0;
             else return 1;
         }
    );

    // Translate the result.
    size_t rankingIdx = 0;

    for (vector<pair<unsigned long, float>>::iterator iter = pageRankValues.begin();
         iter != pageRankValues.end();
         ++iter, ++rankingIdx)
    {
        iter->first = get<0>(prProcValues[rankingIdx]);
        iter->second = get<2>(prProcValues[rankingIdx]);
    }

    return pageRankValues;
}
