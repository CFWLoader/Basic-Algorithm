//
// Created by Exia on 2015/8/19.
//

#ifndef SORTING_COMPARATOR_HPP
#define SORTING_COMPARATOR_HPP

#include <stdint.h>

namespace Comparator
{
    class KeyLess
    {
    public:
        bool operator()(int64_t a,int64_t b)
        {
            if(a > b)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
    };

    class KeyLarger
    {
    public:
        bool operator()(int64_t a, int64_t b)
        {
            if(a > b)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    };
}

#endif //SORTING_COMPARATOR_HPP
