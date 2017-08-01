//
// Created by CFWLoader on 7/31/17.
//

#ifndef PAGERANK_PAGERANKER_H
#define PAGERANK_PAGERANKER_H

#include <vector>

class PageRanker
{
public:

    PageRanker() = default;

    ~PageRanker() = default;

    std::vector<std::pair<unsigned long, float>> pageRank(
            const std::vector<std::vector<unsigned long>>&,
            unsigned long,
            unsigned long,
            float = 1.0,
            float = 0.85
            );

private:
};


#endif //PAGERANK_PAGERANKER_H
