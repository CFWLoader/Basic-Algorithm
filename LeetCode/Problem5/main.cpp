#include <iostream>

#include <algorithm>

using namespace std;

class Solution
{
public:
    string longestPalindrome(string s)
    {

        string::const_iterator targetHead = s.end(), targetEnd = s.end();

        int stringBound = s.size();

        int leftIndex = 0, rightIndex = 0, palindromeSize = 1, currentPalindromeSize;

        int left, right;

        for (int palidromePivot = 0; palidromePivot < stringBound; palidromePivot = rightIndex)
        {
            cout << palidromePivot << endl;

            leftIndex = palidromePivot - 1, rightIndex = palidromePivot + 1;

            currentPalindromeSize = 1;

            while(rightIndex < stringBound and s[palidromePivot] == s[rightIndex])
            {
                ++rightIndex;                   // Pure palindrome.
                ++currentPalindromeSize;
            }

            while (leftIndex >= 0 and rightIndex < stringBound)
            {
                if (s[leftIndex] != s[rightIndex])
                {
                    ++leftIndex, --rightIndex;

                    break;
                }

                --leftIndex, ++rightIndex;

                currentPalindromeSize += 2;
            }

            if (currentPalindromeSize > palindromeSize)
            {
                targetHead = s.begin(), targetEnd = s.begin();

                if(leftIndex < 0 or rightIndex >= stringBound)
                {
                    left = leftIndex + 1, right = rightIndex - 1;
                }
                else
                {
                    left = leftIndex, right = rightIndex;
                }

                advance(targetHead, left);
                advance(targetEnd, right + 1);
            }
        }

        return string(targetHead, targetEnd);
    }
};

int main()
{
    Solution solution;

    string str = "caba";

    string result = solution.longestPalindrome(str);

    cout << result << endl;

    return 0;
}