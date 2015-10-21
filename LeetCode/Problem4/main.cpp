#include <iostream>
#include <vector>
#include <limits>

using namespace std;

class Solution
{
public:
    double findMedianSortedArrays(vector<int> &nums1, vector<int> &nums2)
    {

        int left1 = 0;
        int right1 = nums1.size() - 1;

        int left2 = 0;
        int right2 = nums2.size() - 1;

        int k = (right1 + right2 + 1) / 2;

        if ((right1 + right2 + 1) % 2 != 0)
        {

            double mid1 = this->findKth(nums1, nums2, left1, right1, left2, right2, int(k) + 1);
            double mid2 = this->findKth(nums1, nums2, left1, right1, left2, right2, int(k) + 2);

            double result = (mid1 + mid2) / 2;

            //cout << "mid1: " << mid1 << "  mid2: " << mid2 << "  result: " << result << endl;

            return result;
        }

        else
        {
            //cout << "int k: " << k << endl;

            return this->findKth(nums1, nums2, left1, right1, left2, right2, int(k) + 1);
        }
    }

    double findKth(vector<int> &nums1, vector<int> &nums2, int left1, int right1, int left2, int right2, int k)
    {

        int mid1 = (int)((double)(right1 - left1 + 1) / (right1 - left1 + 1 + right2 - left2 + 1) * (k-1));
        int mid2 = (k-1) - mid1;

        int Ai_1 = ((mid1 == left1) ? numeric_limits<int>::min() : nums1[mid1 - 1]);
        int Bj_1 = ((mid2 == left2) ? numeric_limits<int>::min() : nums2[mid2 - 1]);
        int Ai   = ((mid1 > right1) ? numeric_limits<int>::max() : nums1[mid1]);
        int Bj   = ((mid2 > right2) ? numeric_limits<int>::max() : nums2[mid2]);

        if (Bj_1 < Ai && Ai < Bj)
            return Ai;
        else if (Ai_1 < Bj && Bj < Ai)
            return Bj;

        if (Ai < Bj)
        {
            return this->findKth(nums1, nums2, mid1 + 1, right1 - mid1 - 1, left2, mid2, k - mid1 - 1);
        }
        else
        {
            return this->findKth(nums1, nums2, left1, mid1, mid2 + 1, right2 - mid2 - 1, k - mid2 - 1);
        }
    }
};

int main()
{
    vector<int> nums1 = {1};
    vector<int> nums2 = {1};

    Solution solution;

    cout << solution.findMedianSortedArrays(nums1, nums2);

    return 0;
}