//
// Created by Exia on 2015/8/19.
//

#ifndef SORTING_SORTER_HPP
#define SORTING_SORTER_HPP

#include <iterator>
#include <utility>

#include <vector>
#include <array>

#include "Comparator.hpp"

namespace Sorter
{
    class BubbleSorter
    {
    public:
        template<typename RandomAccessIterator, typename KeyCompareMethod = Comparator::KeyLess>
        static void sort(RandomAccessIterator begin,
                         RandomAccessIterator end,
                         KeyCompareMethod compareMethod = KeyCompareMethod())
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
        template<typename RandomAccessIterator, typename KeyCompareMethod = Comparator::KeyLess>
        static void sort(RandomAccessIterator begin,
                         RandomAccessIterator end,
                         KeyCompareMethod compareMethod = KeyCompareMethod())
        {
            if (begin == end)
            {
                return;
            }

            RandomAccessIterator iterator1, rail, currentEnd = begin + 1;

            while (currentEnd != end)
            {
                iterator1 = begin;

                while (iterator1 != currentEnd)
                {
                    if (!compareMethod(*iterator1, *currentEnd))
                    {
                        break;
                    }

                    ++iterator1;
                }

                rail = currentEnd;

                while (rail != iterator1)
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
        template<typename RandomAccessIterator, typename KeyCompareMethod = Comparator::KeyLess>
        static void sort(RandomAccessIterator begin,
                         RandomAccessIterator end,
                         KeyCompareMethod compareMethod = KeyCompareMethod())
        {
            if (begin == end)
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
                    if (compareMethod(*iterator1, *minPosition))
                    {
                        minPosition = iterator1;
                    }

                    ++iterator1;
                }

                if (currentHead != minPosition)
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
        template<typename RandomAccessIterator, typename KeyCompareMethod = Comparator::KeyLess>
        static void sort(RandomAccessIterator theLeft,
                         RandomAccessIterator theRight,
                         KeyCompareMethod compareMethod = KeyCompareMethod())
        {
            if (std::distance(theLeft, theRight) <= 0)
            {
                return;
            }

            RandomAccessIterator left = theLeft, right = theRight - 1, pivotPosition = theLeft;

            typename RandomAccessIterator::value_type pivot = *pivotPosition;

            while (std::distance(left, right) > 0)
            {
                while ((std::distance(left, right)) > 0 && compareMethod(pivot, *right))
                {
                    --right;
                }
                while ((std::distance(left, right)) > 0 && compareMethod(*left, pivot))
                {
                    ++left;
                }

                if (std::distance(left, right) > 0)
                {
                    std::swap(*left, *right);
                }
            }

            std::swap(*left, *pivotPosition);

            QuickSorter::sort(theLeft, left, compareMethod);
            QuickSorter::sort(left + 1, theRight, compareMethod);
        }
    };

    class MergeSorter
    {
    public:
        template<typename RandomAccessIterator, typename KeyCompareMethod = Comparator::KeyLess>
        static void sort(RandomAccessIterator begin,
                         RandomAccessIterator end,
                         KeyCompareMethod compareMethod = KeyCompareMethod())
        {
            if ((begin == end) || ((begin + 1) == end))
            {
                return;
            }

            int length = std::distance(begin, end);

            MergeSorter::sort(begin, begin + length / 2, compareMethod);
            MergeSorter::sort(begin + length / 2, end, compareMethod);

            std::vector<typename RandomAccessIterator::value_type> valueVector1(begin, begin + length / 2),
                    valueVector2(begin + length / 2, end);

            RandomAccessIterator iterator1 = begin;

            typename std::vector<typename RandomAccessIterator::value_type>::const_iterator valueIterator1 = valueVector1.begin(),
                    valueIterator2 = valueVector2.begin();

            while (valueIterator1 != valueVector1.end() && valueIterator2 != valueVector2.end())
            {
                if(compareMethod(*valueIterator1, *valueIterator2))
                {
                    *iterator1 = *valueIterator1;

                    ++valueIterator1;
                }
                else
                {
                    *iterator1 = *valueIterator2;

                    ++valueIterator2;
                }

                ++iterator1;
            }

            if(valueIterator1 != valueVector1.end())
            {
                while (valueIterator1 != valueVector1.end())
                {
                    *iterator1 = *valueIterator1;

                    ++valueIterator1;

                    ++iterator1;
                }
            }
            else
            {
                while (valueIterator2 != valueVector2.end())
                {
                    *iterator1 = *valueIterator2;

                    ++valueIterator2;

                    ++iterator1;
                }
            }
        }
    };

    class HeapSorter
    {
    public:
        template <typename ValueType, size_t arraySize, typename KeyCompareMethod = Comparator::KeyLess>
        static void sort(std::array<ValueType, arraySize>& sortingArray,
                         KeyCompareMethod compareMethod = KeyCompareMethod())
        {
            //Building the heap.
            for(int index = (arraySize - 1) / 2; index >= 0; --index)
            {
                HeapSorter::heapify(sortingArray, index);
            }

            for(size_t index = arraySize - 1; index > 0; --index)
            {
                std::swap(sortingArray[0], sortingArray[index]);

                HeapSorter::heapify(sortingArray, 0, index);
            }
        }

        template <typename ValueType, size_t arraySize, typename KeyCompareMethod = Comparator::KeyLess>
        static void heapify(std::array<ValueType, arraySize>& sortingArray, size_t index, size_t heapSize = arraySize,
                         KeyCompareMethod compareMethod = KeyCompareMethod())
        {
            size_t targetIndex = index;

            if(HeapSorter::left(index) < heapSize &&
                    compareMethod(sortingArray[targetIndex], sortingArray[HeapSorter::left(index)]))
            {
                targetIndex = HeapSorter::left(index);
            }

            if(HeapSorter::right(index) < heapSize &&
                    compareMethod(sortingArray[targetIndex], sortingArray[HeapSorter::right(index)]))
            {
                targetIndex = HeapSorter::right(index);
            }

            if(targetIndex != index)
            {
                std::swap(sortingArray[targetIndex], sortingArray[index]);

                HeapSorter::heapify(sortingArray, targetIndex, heapSize, compareMethod);
            }
        }

        static size_t left(size_t index)
        {
            return 2 * index + 1;
        }

        static size_t right(size_t index)
        {
            return 2 * (index + 1);
        }
    };

    class CountingSorter
    {
    public:
        template <typename ValueType, size_t arraySize, uint64_t maxValue, typename KeyCompareMethod = Comparator::KeyLess>
        static void sort(std::array<ValueType, arraySize>& sortingArray,
                         KeyCompareMethod compareMethod = KeyCompareMethod())
        {
            std::array<ValueType, arraySize> bArray;
            std::array<ValueType, maxValue + 1> cArray;

            for(int i = 0; i <= maxValue; ++i)
            {
                cArray[i] = 0;
            }

            for(int i = 0; i < arraySize; ++i)
            {
                ++cArray[sortingArray[i]];
            }

            for(int i = 1; i <= maxValue; ++i)
            {
                cArray[i] += cArray[i - 1];
            }

            for(int i = 0; i < arraySize; ++i)
            {
                bArray[cArray[sortingArray[i]]] = sortingArray[i];
                --cArray[sortingArray[i]];
            }

            for(int i = 0; i < arraySize; ++i)
            {
                sortingArray[i] = bArray[i];
            }
        }
    };
}

#endif //SORTING_SORTER_HPP
