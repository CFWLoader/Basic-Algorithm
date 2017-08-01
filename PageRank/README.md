# Page Rank
Core formula:
For each node i in graph G=(V, E):
\begin{equation}
    PR^t(i) = \sum_{j \in G}\frac{PR^{t-1}(j)}{N(j)}
\end{equation}
N(x) means the direct neighbors of x. Every new page rank values depend on last iteration's.