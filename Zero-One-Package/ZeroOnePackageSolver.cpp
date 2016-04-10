//
// Created by cfwloader on 4/10/16.
//

#include "ZeroOnePackageSolver.h"

ZeroOnePackageSolver::ZeroOnePackageSolver() : dynamicalProgrammingMatrix(0)
{}

size_t ZeroOnePackageSolver::maxValue(const std::vector<size_t> &values, const std::vector<size_t> &weights, size_t volume)
{

    size_t valueBound = values.size();


    this->clear(valueBound, volume);

    for (size_t i = 1; i <= valueBound; ++i)
    {
        for (size_t j = weights[i]; j <= volume; ++j)
        {
            dynamicalProgrammingMatrix[i][j] = (dynamicalProgrammingMatrix[i - 1][j] > dynamicalProgrammingMatrix[i - 1][j - weights[i]]+ values[i]) ?
                                               dynamicalProgrammingMatrix[i - 1][j] :
                                               dynamicalProgrammingMatrix[i - 1][j - weights[i]] + values[i];
        }
    }

    return dynamicalProgrammingMatrix[valueBound][volume];
}

void ZeroOnePackageSolver::clear(size_t valueBound, size_t weightBound)
{
    if(valueBound + 1 > dynamicalProgrammingMatrix.size())
    {
        dynamicalProgrammingMatrix.resize(valueBound + 1, std::vector<size_t>(weightBound + 1, 0));
    }
    else
    {
        for (int i = 0; i <= valueBound; ++i)
        {
            for (int j = 0; j <= weightBound; ++j)
            {
                dynamicalProgrammingMatrix[i][j] = 0;
            }
        }
    }
}
