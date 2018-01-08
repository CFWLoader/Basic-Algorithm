# Support Vector Machine

## Preliminary
### How to solve Linear Perceptron's weight and bias
Here is [source](https://zhuanlan.zhihu.com/p/23478187).

Here we assume readers has basic knowledge of Linear Perceptron. Thus we directly head for how to solve perceptron's weight and bias.

$$
  y=\sigma(s+b)=
  \begin{cases}
    0, s\leq0 \newline
	1, s\gt0
  \end{cases}
$$

Activation Function, normally is `Logistic`:

$$
\sigma(x)=\frac{1}{1+e^{-x}}
$$

Perceptron will generate an output <I>y</I> for input vector <B><I>x</I></B>. $\hat{y}$ is known classification for input vector <B><I>x</I></B>.

Normally, the error between actual output and expected output would be defined as:

$$
E=\frac{1}{2}(y-\hat{y})^2
$$

It also can be defined as $E=|y-\hat{y}|$. But normally choose the former for convenience.

The process of machine learning is minimize the error. Thus the process requires fixing weights of perceptrons.

For fixing weights, the training process uses $\Delta w_i=-\alpha\frac{\partial E}{\partial w_i}$.

Use some trick for this formula:

$$
\frac{\partial E}{\partial w_i}=\frac{\partial E}{\partial y}\frac{\partial y}{\partial s}\frac{\partial s}{\partial w_i}=(y-\hat{y})\sigma'(s)x_i
$$

Sometimes derivatives of activation function are always non-negative, thus can be omitted. Then the solution becomes:

$$
\Delta w_i=\alpha(\hat{y}-y)x_i
$$