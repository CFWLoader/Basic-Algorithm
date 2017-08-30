# Louvain Community Detection Algorithm
### For G=(V,E). The core formula related to Louvain:
### Modularity of a community:
\begin{equation}
Q = \frac{1}{2m}\sum_{i,j}[A(i,j) - \frac{k_ik_j}{2m}]\delta(c_i,c_j)
\end{equation}

\begin{equation}
\delta(c_i,c_j)=\begin{array}
\text{1 ~~ if ~~ c_i == c_j},\newline
\text{0 else}
\end{array}
\end{equation}

\begin{equation}
A(i,j) 
\end{equation}
is the weight of the edge from i to j.

\begin{equation}
c_x
\end{equation} is the community of x.

\begin{equation}
k_{i} = \sum_{j}A(i,j)
\end{equation}