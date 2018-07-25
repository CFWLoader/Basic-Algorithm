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

$$
f(i) =
\begin{cases}
f(i - 1) + 1, & ~ A[i] > A[i - 1], i >1 \\
1, & ~ A[i]<A[i-1] ~or~i=1
\end{cases}
$$

### 3 - Edit Distance

Let A denotes the original string, B denotes the expected string.

Three ways to transform string A to B, every operation take 1 cost:
- Insert a character, use insert(string, index, char) to represent this operation.
- Delete a character, use delete(string, index) to represent this operation.
- Replace a character, use replace(string, index, char) to represent this operation.

For example(index starts from 1):

```
insert("ABC", 2, 'D') = "ABDC"
delete("ABC", 2) = "AC"
replace("ABC", 2, 'E') = "AEC"
```

Then the state transfer function:

$$
f(i, j) = 
\begin{cases}
f(i - 1, j - 1), & A[i] == B[j], i > 1, j > 1 \\
\end{cases}
$$