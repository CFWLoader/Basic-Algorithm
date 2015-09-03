//
// Created by Exia on 2015/8/25.
//

#ifndef MATRIX_CHAIN_ORDER_MATRIXCHAIN_H
#define MATRIX_CHAIN_ORDER_MATRIXCHAIN_H

#include <vector>

class MatrixChain
{
public:

    explicit MatrixChain(const std::vector<int>& matrixDimensions);

    void calculate ();

    std::vector<std::vector<int>>& getCostMatrix();

    std::vector<std::vector<int>>& getTraceMatrix();

private:

    static int INFINITY_COST;

    std::vector<int> dimensions_;

    std::vector<std::vector<int>> cost_;

    std::vector<std::vector<int>> trace_;
};


#endif //MATRIX_CHAIN_ORDER_MATRIXCHAIN_H
