//
// Created by Exia on 2015/8/19.
//

#ifndef SORTING_SORTER_HPP
#define SORTING_SORTER_HPP

#include <iterator>
#include <utility>

//#define DEBUGGING

#ifdef DEBUGGING
#include <iostream>

#endif

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

            RandomAccessIterator iterator1, rail, currentEnd = begin + 1;

            while(currentEnd != end)
            {
                iterator1 = begin;

                while(iterator1 != currentEnd)
                {
                    if(!compareMethod(*iterator1, *currentEnd))
                    {
                        break;
                    }

                    ++iterator1;
                }

                rail = currentEnd;

                while(rail != iterator1)
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

            RandomAccessIterator iterator1, currentHead = begin, minPosition;

            while (currentHead != end)
            {
                iterator1 = currentHead;

                minPosition = currentHead;

                while (iterator1 != end)
                {
                    if(compareMethod(*iterator1, *minPosition))
                    {
                        minPosition = iterator1;
                    }

                    ++iterator1;
                }

                if(currentHead != minPosition)
                {
                    std::swap(*currentHead, *minPosition);
                }

                ++currentHead;
            }
        }
    };

    class QuickSorter
    {
    public:
        template <typename RandomAccessIterator, typename KeyCompareMethod>
        static void sort(RandomAccessIterator theLeft, RandomAccessIterator theRight, KeyCompareMethod compareMethod)
        {
            if(std::distance(theLeft, theRight) <= 0)
            {
                return;
            }

            RandomAccessIterator left = theLeft, right = theRight, pivotPosition = theLeft;

            typename RandomAccessIterator::value_type pivot = *pivotPosition;

            #ifdef DEBUGGING
            std::cout << "Pivot: " << pivot << std::endl;
            #endif

            while(std::distance(left, right) > 0)
            {
                while((std::distance(left, right)) > 0 && compareMethod(pivot, *right))
                {
                    --right;
                }
                while((std::distance(left, right)) > 0 && compareMethod(*left, pivot))
                {
                    ++left;
                }

                if(std::distance(left, right) > 0)
                {
                    std::swap(*left, *right);
                }
            }

            std::swap(*left, *pivotPosition);

            QuickSorter::sort(theLeft, left - 1, compareMethod);
            QuickSorter::sort(left + 1, theRight, compareMethod);
        }
    };
}

#endif //SORTING_SORTER_HPP
