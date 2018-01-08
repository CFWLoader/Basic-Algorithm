# Copy from https://zhuanlan.zhihu.com/p/26008081

import numpy
import matplotlib.pyplot

class RefLayer:
    # 初始化 dim_out 个神经元构成的单层神经网络，输出为 dim_in 维
    def __init__(self, dim_in, dim_out):
        # 随机初始化权值矩阵 weight
        self.weight = numpy.matrix(numpy.random.rand(dim_in, dim_out))
        # 初始化神经元的偏置 bias
        self.bias = numpy.zeros(dim_out)

    # 计算神经网络在输入为 x 时的输出
    def compute(self, x):
        sum = x * self.weight + self.bias
        # 采用 ReLU，将小于零的神经元输出置为 0
        lessThanZero = sum < 0
        sum[lessThanZero] = 0
        return sum

    # 根据输入 x 和 输出 y 进行一轮学习，学习率为 rate
    def learn(self, x, y, rate):
        x = numpy.matrix(x, copy=False)
        y1 = self.compute(x)
        # 计算激活函数的导数 derivative
        derivative = numpy.ones(y1.shape)
        isZero = y1 == 0
        derivative[isZero] = 0
        # 修正权值和偏置
        delta = numpy.multiply(y - y1, derivative)
        self.weight = self.weight + numpy.transpose(x) * delta * rate
        self.bias = self.bias + numpy.ones([1, x.shape[0]]) * delta * rate


if __name__ == "__main__":

    a = RefLayer(2, 1)
    x = numpy.array([[1, 2], [2, 1], [3, 1], [1, 3], [2, 3], [3, 2]])
    y = numpy.array([[0], [0], [0], [1], [1], [1]])

    for i in range(1000):
        # print(a.compute(x))
        a.learn(x, y, 0.01)
        # print(a.weight, a.bias)

    fig, ax = matplotlib.pyplot.subplots()
    ax.plot(x[:3, 0], x[:3, 1], "bo")
    ax.plot(x[3:, 0], x[3:, 1], "ro")
    xs = numpy.arange(0, 5)
    ys = (0.5 - a.bias[0, 0] - xs * a.weight[0, 0]) / a.weight[1, 0]
    ax.plot(xs, ys, "k--")
    matplotlib.pyplot.show()