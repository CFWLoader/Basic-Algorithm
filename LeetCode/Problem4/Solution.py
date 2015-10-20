__author__ = 'cfwloader'

class Solution(object):
    def findMedianSortedArrays(self, nums1, nums2):
        """
        :type nums1: List[int]
        :type nums2: List[int]
        :rtype: float
        """

        left1 = 0
        right1 = len(nums1) - 1
        mid1 = left1 + int((right1 - left1) / 2)

        left2 = 0
        right2 = len(nums2) - 1
        mid2 = left2 + int((right2 - left2) / 2)

        print('mid1: %d   mid2: %d' % (mid1, mid2))


if __name__ == '__main__':

    nums1 = [1, 3, 5, 7]
    nums2 = [2, 4, 6, 8]

    solution = Solution()

    solution.findMedianSortedArrays(nums1, nums2)