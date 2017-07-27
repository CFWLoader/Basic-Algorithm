//
// Created by CFWLoader on 7/27/17.
//

#ifndef PROBLEM457_SOLUTION_HPP
#define PROBLEM457_SOLUTION_HPP

#include <vector>

using namespace std;

class Solution
{
public:

    int fixNegativeIndex(int idxValue, int loopSize)
    {
        while (idxValue + loopSize < 0)
        {
            idxValue += loopSize;
        }

        return idxValue;
    }

    bool circularArrayLoopRec(vector<int> &nums, int current, size_t bound)
    {
        if (current == bound)
        {
            return false;
        }
        else if (nums[current] == 0)
        {
            return circularArrayLoopRec(nums, current + 1, bound);
        }
        else
        {
            int next = current + nums[current];

            nums[current] = 0;

            if (next > bound)next %= bound;
            if (next < 0)next = fixNegativeIndex(next, bound);

            if(next != current && nums[next] == 0)
            {
                return true;
            }
            else if(next != current && nums[next] != 0)
            {
                return circularArrayLoopRec(nums,  next, bound);
            }
            else
            {
                return false;
            }

        }
    }

    bool circularArrayLoop(vector<int> &nums)
    {

        return circularArrayLoopRec(nums, 0, nums.size());

    }
};

#endif //PROBLEM457_SOLUTION_HPP
