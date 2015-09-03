//
// Created by Exia on 2015/8/25.
//

#include <limits>
#include "MatrixChain.h"

int MatrixChain::INFINITY_COST = std::numeric_limits<int>::max();

MatrixChain::MatrixChain(const std::vector<int> &matrixDimensions) :
    dimensions_(matrixDimensions),
    cost_(matrixDimensions.size() - 1),
    trace_(matrixDimensions.size() - 1)
{
    int numberOfMatrice = matrixDimensions.size();

    for (int i = 0; i < numberOfMatrice; ++i) {

        cost_[i].resize(numberOfMatrice);
        trace_[i].resize(numberOfMatrice);

        for (int j = 0; j < numberOfMatrice; ++j) {
            cost_[i][j] = INFINITY_COST;
            trace_[i][j] = INFINITY_COST;
        }
    }
}

void MatrixChain::calculate() {

}

std::vector<std::vector<int>> &MatrixChain::getCostMatrix() {
    return cost_;
}

std::vector<std::vector<int>> &MatrixChain::getTraceMatrix() {
    return trace_;
}
