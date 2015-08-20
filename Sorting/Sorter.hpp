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

    class InsertSorter
    {
    public:
        template <typename RandomAccessIterator, typename KeyCompareMethod>
        static void sort(RandomAccessIterator begin, RandomAccessIterator end, KeyCompareMethod compareMethod)
        {
            if(begin == end)
            {
                return;
            }

            RandomAccessIterator iterator, rail, currentEnd = begin + 1;

            while(currentEnd != end)
            {
                iterator = begin;

                while(iterator != currentEnd)
                {
                    if(!compareMethod(*iterator, *currentEnd))
                    {
                        break;
                    }

                    ++iterator;
                }

                rail = currentEnd;

                while(rail != iterator)
                {
                    std::swap(*rail, *(rail - 1));

                    --rail;
                }

                ++currentEnd;
            }

        }
    };

    class SelectSorter
    {
    public:
        template <typename RandomAccessIterator, typename KeyCompareMethod>
        static void sort(RandomAccessIterator begin, RandomAccessIterator end, KeyCompareMethod compareMethod)
        {
            if(begin == end)
            {
                return;
            }

            RandomAccessIterator iterator, currentHead = begin, minPosition;

            while (currentHead != end)
            {
                iterator = currentHead;

                minPosition = currentHead;

                while (iterator != end)
                {
                    if(compareMethod(*iterator, *minPosition))
                    {
                        minPosition = iterator;
                    }

                    ++iterator;
                }

                if(currentHead != minPosition)
                {
                    std::swap(*currentHead, *minPosition);
                }

                ++currentHead;
            }
        }
    };
}

#endif //SORTING_SORTER_HPP
