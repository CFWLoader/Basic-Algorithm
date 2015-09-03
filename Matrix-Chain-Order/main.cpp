//
// Created by cfwloader on 9/3/15.
//

#include <iostream>

#include "MatrixChain.h"

using namespace std;

int main(int argc, char* argv[])
{
    vector<int> dimension = {3, 6, 9, 12};

    MatrixChain matrixChain(dimension);

    for (int i = 0; i < matrixChain.getCostMatrix().size(); ++i) {

        for (int j = 0; j < matrixChain.getCostMatrix().size(); ++j) {
            cout << matrixChain.getCostMatrix()[i][j] << " ";
        }

        cout << endl;
    }

    return 0;
}
