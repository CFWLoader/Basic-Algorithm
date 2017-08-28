//
// Created by CFWLoader on 8/28/17.
//

#ifndef LOVAIN_LOUVAIN_HPP
#define LOVAIN_LOUVAIN_HPP

#include <map>
#include <set>

using std::map;
using std::set;

class Vertex
{
public:

    Vertex(unsigned long node_num_) : node_num(node_num_), neighbors(){}

    bool add_neighbor(const Vertex* neighbor, double cost = 1.0)
    {
        if(neighbors.find(neighbor) == neighbors.end())
        {
            neighbors[neighbor] = cost;
        }

        return true;
    }

    unsigned long node_num;

    map<const Vertex*, double> neighbors;
};

double modularity(set<const Vertex*> community)
{

    return 0;
}

#endif //LOVAIN_LOUVAIN_HPP
