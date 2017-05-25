//
// Created by CFWLoader on 5/25/17.
//

#ifndef TOP_K_GREATEST_FREQUENCY_HELPER_HPP
#define TOP_K_GREATEST_FREQUENCY_HELPER_HPP

#include <string>
#include <fstream>
#include <random>

#include <iostream>

int generate_random_integers(std::string filePath, uint64_t data_to_gen)
{
    std::ofstream outFile(filePath);

    std::random_device rd;

    std::mt19937_64 seed(rd());

    std::uniform_int_distribution<uint> rand_engine;

    for(uint64_t i = 0; i < data_to_gen; ++i)
    {
        outFile << rand_engine(seed) << std::endl;
    }

    outFile.close();

    return 0;
}

int read_number_data(std::string filePath)
{
    std::ifstream input(filePath);

    std::string buf;

    unsigned int number;

    while(!input.eof())
    {
        input >> buf;

        number = strtol(buf.c_str(), NULL, 10);

        std::cout << number << std::endl;
    }

    input.close();
}

#endif //TOP_K_GREATEST_FREQUENCY_HELPER_HPP
