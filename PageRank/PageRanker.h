//
// Created by CFWLoader on 7/31/17.
//

#ifndef PAGERANK_PAGERANKER_H
#define PAGERANK_PAGERANKER_H

#include <vector>

static const float DAMPING_FACTOR = 0.85;

class PageRanker
{
public:

    PageRanker() = default;

    ~PageRanker() = default;

    std::vector<std::pair<unsigned long, float>> pageRank(
            const std::vector<std::vector<unsigned long>>&,
            unsigned long,
            float,
            unsigned long);

private:
};


#endif //PAGERANK_PAGERANKER_H
