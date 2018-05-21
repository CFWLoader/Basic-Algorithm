# Broyden–Fletcher–Goldfarb–Shanno algorithm

[Wiki](https://en.wikipedia.org/wiki/Broyden%E2%80%93Fletcher%E2%80%93Goldfarb%E2%80%93Shanno_algorithm)

In the algorithm, the approximate matrix $B$ to be updated with:

$$
B_{k+1} = B_k + \frac{\mathbf{y}_k \mathbf{y}_k^T}{\mathbf{y}_k^T \mathbf{s}_k} - \frac{B_k\mathbf{s}_k \mathbf{s}_k^T B_k}{\mathbf{s}_k^T B_k \mathbf{s}_k}
$$

where

$$
\begin{align}
\mathbf{s}_k & = \mathbf{x}_{k+1} - \mathbf{x}_{k} \\
\mathbf{y}_k & = \nabla f(\mathbf{x}_{k+1}) - \nabla f(\mathbf{x}_{k})
\end{align}
$$

or using this following update:

$$
B_{k+1}^{-1} = (I - \frac{\mathbf{s}_k \mathbf{y}_k^T}{\mathbf{y}_k^T \mathbf{s}_k}) B_{k}^{-1} (I - \frac{\mathbf{s}_k \mathbf{y}_k^T}{\mathbf{y}_k^T \mathbf{s}_k}) +  \frac{\mathbf{s}_k \mathbf{s}_k^T}{\mathbf{y}_k^T \mathbf{s}_k}
$$

Whichever formula we use, there is issue that $\mathbf{y}_k^T \mathbf{s}_k$ might be `zero` which would cause failure of the algorithm.

The solution in `scipy.optimize._minimize_bfgs()` is that if $\mathbf{y}_k^T \mathbf{s}_k = 0$, just let $(\mathbf{y}_k^T \mathbf{s}_k)^{-1} = 1000$ and give a warning.

This solution may suit to [DFP Method](https://en.wikipedia.org/wiki/Davidon%E2%80%93Fletcher%E2%80%93Powell_formula).