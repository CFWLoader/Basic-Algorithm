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


    for (size_t idx = 1; num_ver_mapping.find(idx) != num_ver_mapping.end(); ++idx)
    {
        graph.push_back(num_ver_mapping[idx]);
    }

    ifstream1.close();

    return graph;
}

vector<const Vertex *> load_directed_edge_graph(string file_path)
{
    ifstream ifstream1(file_path);

    if(!ifstream1.is_open())
    {
        throw "Bad file path!";
    }

    vector<const Vertex *> graph;

    map<int, Vertex *> num_ver_mapping;

    Vertex *ver_ptr = nullptr;

    string buf;

//    int load_counter = 0;

    while (std::getline(ifstream1, buf))
    {
//        std::cout << "Loading:" << load_counter << std::endl;

        istringstream ss(buf);
        istream_iterator<int> the_begin(ss), the_end;

        vector<int> array_tokens(the_begin, the_end);

        if (num_ver_mapping.find(array_tokens[0]) == num_ver_mapping.end())
            num_ver_mapping[array_tokens[0]] = new Vertex(array_tokens[0]);

        ver_ptr = num_ver_mapping[array_tokens[0]];

        if (num_ver_mapping.find(array_tokens[1]) == num_ver_mapping.end())
        {
            num_ver_mapping[array_tokens[1]] = new Vertex(array_tokens[1]);
        }

        ver_ptr->add_neighbor(num_ver_mapping[array_tokens[1]], 1);

//        ++load_counter;

    }


//    for (size_t idx = 1; num_ver_mapping.find(idx) != num_ver_mapping.end(); ++idx)
//    {
//        graph.push_back(num_ver_mapping[idx]);
//    }
    for(map<int, Vertex *>::const_iterator iter = num_ver_mapping.begin();
            iter != num_ver_mapping.end();
            ++iter)
    {
        graph.push_back(iter->second);
    }

    ifstream1.close();

    return graph;
}

bool release_graph(vector<const Vertex *> &graph)
{
    for (vector<const Vertex *>::iterator iterator1 = graph.begin();
         iterator1 != graph.end();
         ++iterator1)
    {
        delete (*iterator1);

        *iterator1 = nullptr;
    }

    return true;
}

double modularity(set<const Vertex *> &community, double total_weight, bool directed = false)
{

    map<const Vertex *, double> k_values;

    if (!directed)
    {
        total_weight *= 2;
    }

    double q_value = 0;

    for (set<const Vertex *>::const_iterator vertex_iter = community.begin();
         vertex_iter != community.end();
         ++vertex_iter)
    {

        k_values[*vertex_iter] = 0;

        for (map<const Vertex *, double>::const_iterator neighbor_iter = ((*vertex_iter)->neighbors).begin();
             neighbor_iter != ((*vertex_iter)->neighbors).end();
             ++neighbor_iter)
        {
            k_values[*vertex_iter] += neighbor_iter->second;
        }

        // std::cout << (*vertex_iter)->node_num << ": " << k_values[*vertex_iter] << std::endl;
    }

    for (set<const Vertex *>::const_iterator vertex = community.begin();
         vertex != community.end();
         ++vertex)
    {
        for (map<const Vertex *, double>::const_iterator neighbor = ((*vertex)->neighbors).begin();
             neighbor != ((*vertex)->neighbors).end();
             ++neighbor)
        {
            if (community.find(neighbor->first) == community.end())
            {
                continue;
            }

            //std::cout << k_values[*vertex] * k_values[neighbor->first] << std::endl;

            q_value += (neighbor->second - k_values[*vertex] * k_values[neighbor->first] / total_weight);
        }
    }

    return q_value / total_weight;
}

map<const Vertex *, set<const Vertex *>> louvain(vector<const Vertex *> &graph, bool directed = false)
{
    map<const Vertex *, set<const Vertex *>> partitions;

    double total_weight = 0;

    std::cout << "Creating single comms." << std::endl;

    for (auto vertex : graph)
    {
        //cout << vertex->node_num << ":";
        partitions[vertex] = set<const Vertex *>({vertex});

        for (auto neighbor : vertex->neighbors)
        {
            // cout << neighbor.second << " ";

            total_weight += neighbor.second;
        }

        // cout << endl;
    }

    std::cout << "Finished Creating single comms." << std::endl;

    if (!directed)
    {
        total_weight /= 2;
    }

    double max_delta_q = 1, delta_q;

    const Vertex *merging1, *merging2;

    // std::cout << "Initial partition size: " << partitions.size() << std::endl;
    std::cout << "Applying Louvain." << std::endl;

    while (max_delta_q > 0)
    {
        max_delta_q = -1.1;

        merging1 = merging2 = nullptr;

        for (auto partition : partitions)
        {
            for (auto neighbor : partition.first->neighbors)
            {
                if (partitions.find(neighbor.first) == partitions.end())
                {
                    continue;
                }

                set<const Vertex *> new_set(partitions[neighbor.first].begin(), partitions[neighbor.first].end());

                delta_q = modularity(new_set, total_weight);

                new_set.insert(partition.second.begin(), partition.second.end());

                delta_q = modularity(new_set, total_weight) - delta_q;

                if (delta_q > max_delta_q)
                {
                    max_delta_q = delta_q;

                    merging1 = partition.first;

                    merging2 = neighbor.first;
                }

            }
        }

        if (max_delta_q > 0)
        {
            if (merging1 == nullptr or merging2 == nullptr)
            {
                throw "Bad Logic!";
            }

            std::cout << "Merging: " << merging1->node_num << " and " << merging2->node_num << std::endl;

            partitions[merging1].insert(partitions[merging2].begin(), partitions[merging2].end());

            partitions.erase(merging2);
        }

        // std::cout << partitions.size() << std::endl;
    }

    return partitions;
}

#endif //LOVAIN_LOUVAIN_HPP
