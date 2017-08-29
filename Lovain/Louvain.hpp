//
// Created by CFWLoader on 8/28/17.
//
/***
 * Current version only support undirected graph.
 ***/

#ifndef LOVAIN_LOUVAIN_HPP
#define LOVAIN_LOUVAIN_HPP

#include <map>
#include <set>
#include <vector>
#include <fstream>
#include <sstream>
#include <iterator>

using std::map;
using std::set;
using std::vector;
using std::ifstream;
using std::string;
using std::istringstream;
using std::istream_iterator;

class Vertex
{
public:

    Vertex(unsigned long node_num_) : node_num(node_num_), neighbors() {}

    bool add_neighbor(const Vertex *neighbor, double cost = 1.0)
    {
        if (neighbors.find(neighbor) == neighbors.end())
        {
            neighbors[neighbor] = cost;
        }

        return true;
    }

    unsigned long node_num;

    map<const Vertex *, double> neighbors;
};

vector<const Vertex *> load_graph(string file_path)
{
    ifstream ifstream1(file_path);

    vector<const Vertex *> graph;

    map<int, Vertex *> num_ver_mapping;

    Vertex *ver_ptr = nullptr;

    string buf;

    while (std::getline(ifstream1, buf))
    {
        istringstream ss(buf);
        istream_iterator<int> the_begin(ss), the_end;

        vector<int> array_tokens(the_begin, the_end);

        if (num_ver_mapping.find(array_tokens[0]) == num_ver_mapping.end())
            num_ver_mapping[array_tokens[0]] = new Vertex(array_tokens[0]);

        ver_ptr = num_ver_mapping[array_tokens[0]];

        for (size_t idx = 1; idx != array_tokens.size(); idx += 2)
        {

            if (num_ver_mapping.find(array_tokens[idx + 1]) == num_ver_mapping.end())
            {
                num_ver_mapping[array_tokens[idx + 1]] = new Vertex(array_tokens[idx + 1]);
            }

            ver_ptr->add_neighbor(num_ver_mapping[array_tokens[idx + 1]], array_tokens[idx]);
        }

    }


    for(size_t idx = 1; num_ver_mapping.find(idx) != num_ver_mapping.end(); ++idx)
    {
        graph.push_back(num_ver_mapping[idx]);
    }

    ifstream1.close();

    return graph;
}

bool release_graph(vector<const Vertex *> graph)
{
    for(vector<const Vertex*>::iterator iterator1 = graph.begin();
        iterator1 != graph.end();
        ++iterator1)
    {
        delete (*iterator1);

        *iterator1 = nullptr;
    }

    return true;
}

double modularity(set<const Vertex *> community)
{
    for (set<const Vertex *>::const_iterator vertex = community.begin();
         vertex != community.end();
         ++vertex)
    {
        for (map<const Vertex *, double>::const_iterator neighbor = ((*vertex)->neighbors).begin();
             neighbor != ((*vertex)->neighbors).end();
             ++neighbor)
        {

        }
    }

    return 0;
}

#endif //LOVAIN_LOUVAIN_HPP
