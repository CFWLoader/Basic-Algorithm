from ref.RefLayer import RefLayer
import numpy

class Perceptron:
    def __init__(self, dim_in):

        self.weights = [1 for i in range(0, dim_in)]

        self.bias = 1

    def predict(self, x):

        result = []

        size_limit = len(self.weights)

        for single in x:

            sum = 0

            for i in range(0, size_limit):
                sum += single[i] * self.weights[i]

            # result.append(1 if 1 / (1 + math.exp(-sum)) > 0 else 0)
            result.append(1 if 1 / sum > 0 else 0)

        return result

    def train(self, x, y, epoch=1, rate=0.01):

        weight_size = len(self.weights)

        for epoch_count in range(0, epoch):

            y1 = self.predict(x)

            delta = [0 for i in range(0, weight_size)]

            for x_idx in range(0, len(x)):

                for i in range(0, weight_size):

                    delta[i] += (y[x_idx] - y1[x_idx]) * x[x_idx][i]

            for i in range(0, weight_size):

                self.weights[i] += delta[i] * rate

                self.bias += delta[i] * rate / weight_size

            # print("W: ", self.weights, "  b: ", self.bias)


def match_rate(y1, y2):

    match_count = 0

    for i in range(0, len(y1)):

        if y1[i][0] == y2[i][0]:

            match_count += 1

    return match_count / len(y1)


if __name__ == '__main__':

    # perc = Perceptron(2)
    #
    # x = [[1, 2], [2, 1], [3, 1], [1, 3], [2, 3], [3, 2]]
    #
    # y = [0, 0, 0, 1, 1, 1]
    #
    # for epoch in range(0, 6000):
    #
    #     perc.train(x, y)
    #
    #     result = perc.predict(x)
    #
    #     # print("Epoch: ", epoch, "  Match rate: ", match_rate(result, y), "%")
    #
    # print("Match Rate: ", match_rate(result, y))

    alayer = RefLayer(2,1)

    xn = numpy.array([[1, 2], [2, 1], [3, 1], [1, 3], [2, 3], [3, 2]])
    yn = numpy.array([[0], [0], [0], [1], [1], [1]])

    for i in range(60):
        # print(a.compute(x))
        alayer.learn(xn, yn, 0.01)
        # print(a.weight, a.bias)

    ref_result = alayer.compute(xn)

    fig_result = []

    for i in range(0, len(ref_result)):

        if ref_result[i][0] > 0:

            fig_result.append([1])

        else:

            fig_result.append([0])

    print("Match Rate: ", match_rate(fig_result, yn))