# Dynamic Programming 20 Classic Problems

[GeeksForGeeks](https://www.geeksforgeeks.org/top-20-dynamic-programming-interview-questions/)

[Quora](https://www.quora.com/What-are-the-top-10-most-popular-dynamic-programming-problems-among-interviewers)

### 1 - Longest Common Subsequence

Let A denotes string 1 and B for string 2, then 1 means true and 0 for false.

State Transfer Function:

$$
f(i,j)
=
\begin{cases}
max(f(i - 1, j), f(i, j - 1)) + (A[i]==B[j]), ~ i,j>1 \\
A[i] == B[j], i == 0 ~ or ~ j == 0
\end{cases}
$$

### 2 - Longest Increasing Subsequence