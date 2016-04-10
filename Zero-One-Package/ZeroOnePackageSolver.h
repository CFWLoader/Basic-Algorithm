//
// Created by cfwloader on 4/10/16.
//

#ifndef ZERO_ONE_PACKAGE_ZEROONEPACKAGESOLVER_H
#define ZERO_ONE_PACKAGE_ZEROONEPACKAGESOLVER_H

#include <vector>
#include <stddef.h>

class ZeroOnePackageSolver
{
public:

    ZeroOnePackageSolver();

    size_t maxValue(const std::vector<size_t>&, const std::vector<size_t>&, size_t);

private:

    void clear(size_t, size_t);

    std::vector<std::vector<size_t>> dynamicalProgrammingMatrix;

};


#endif //ZERO_ONE_PACKAGE_ZEROONEPACKAGESOLVER_H
