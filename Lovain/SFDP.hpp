//
// Created by CFWLoader on 9/14/17.
//

#ifndef LOVAIN_SFDP_HPP
#define LOVAIN_SFDP_HPP

#include <fstream>

#include "Louvain.hpp"

namespace SFDP
{
    bool writeSfdpFormat(string out_path, map<const Vertex*, std::set<const Vertex*>> partitions)
    {
        std::ofstream out(out_path);

        if(!out.is_open())
        {
            return false;
        }

        out << "graph{" << std::endl;

        for(map<const Vertex*, std::set<const Vertex*>>::const_iterator partition_iter = partitions.begin();
                partition_iter != partitions.end();
                ++partition_iter)
        {
            out << "subgraph cluster_" << partition_iter->first->node_num << "{" << std::endl;

            for(std::set<const Vertex*>::const_iterator ver_iter = partition_iter->second.begin();
                    ver_iter != partition_iter->second.end();
                    ++ver_iter)
            {
                out << (*ver_iter)->node_num << ";" << std::endl;
            }

            out << "}" << std::endl;
        }

        out << "}";

        out.close();

        return true;
    }
};

#endif //LOVAIN_SFDP_HPP
