#include <iostream>
#include <cmath>

using namespace std;

inline double entropy(double prob)
{
    return prob * log(prob);
}

inline double entropyGain(double prob1, double prob2)
{
    return entropy(prob1) - entropy(prob2);
}

int main(int argc, char* argv[])
{
    return 0;
}