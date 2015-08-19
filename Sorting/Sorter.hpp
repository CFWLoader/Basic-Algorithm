//
// Created by Exia on 2015/8/19.
//

#ifndef SORTING_SORTER_HPP
#define SORTING_SORTER_HPP

#include <utility>

namespace Sorter
{
    class BubbleSorter
    {
    public:
        template<typename RandomAccessIterator, typename KeyCompareMethod>
        static void sort(RandomAccessIterator begin, RandomAccessIterator end, KeyCompareMethod compareMethod)
        {
            RandomAccessIterator theBegin, next, theEnd = end;

            while (begin != theEnd)
            {
                theBegin = begin;

                next = theBegin + 1;

                while (next != theEnd)
                {
                    if (compareMethod(*theBegin, *next))
                    {
                        std::swap(*theBegin, *next);
                    }

                    ++theBegin;
                    ++next;
                }

                theEnd = theBegin;
            }
        }
    };
}

#endif //SORTING_SORTER_HPP
