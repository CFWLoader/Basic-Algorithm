#include <iostream>
#include <vector>

/*******************************************
 *
 *
 *
 *
 * MLE and I don't want to solve it.
 *
 *
 *
 * 
 *******************************************/
using namespace std;

static vector<pair<unsigned int, unsigned long>> fibonnaciNumbers(10000);

static unsigned int bound = 10000;

static unsigned int calculatedPosition = 1;

void initialize()
{
    fibonnaciNumbers[0] = {0, 0}, fibonnaciNumbers[1] = {1, 1};
}

pair<unsigned int, unsigned long> maxPeach(unsigned long total)
{
    if (total <= 1)
    {
        return {1, 1};
    }

    unsigned long left = total;

    unsigned int i;

    for (i = 1; fibonnaciNumbers[i].second < left; ++i)
    {
        if (i + 1 > calculatedPosition)
        {

            if (i + 1 >= bound)
            {
                bound *= 2;

                fibonnaciNumbers.resize(bound);
            }

            fibonnaciNumbers[i + 1].first = fibonnaciNumbers[i - 1].first + fibonnaciNumbers[i].first;

            fibonnaciNumbers[i + 1].second = fibonnaciNumbers[i].second + fibonnaciNumbers[i + 1].first;

            calculatedPosition = i;
        }

        // printf("%u: {%u, %lu}\n", i, fibonnaciNumbers[i].first, fibonnaciNumbers[i].second);
    }

    if (left < fibonnaciNumbers[i].second)
    {
        return {i - 1, fibonnaciNumbers[i - 1].first};
    }
    else
    {
        return {i, fibonnaciNumbers[i].first};
    }

}

int main()
{
    initialize();

    unsigned long n;

    pair<unsigned int, unsigned long> result;

    while (scanf("%lu", &n) != EOF)
    {
        result = maxPeach(n);

        printf("%d %lu\n", result.first, result.second);
    }

    return 0;
}