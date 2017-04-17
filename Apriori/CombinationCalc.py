import operator
from functools import reduce
import math

def c(n,k):
    return  reduce(operator.mul, range(n - k + 1, n + 1)) /reduce(operator.mul, range(1, k +1))


def fac(n):
    return reduce(operator.mul, range(1,n+1))


# print(c(34,3))

x = -999999999

print(math.sqrt(x ** 2 + 4 * x + 1) + x)