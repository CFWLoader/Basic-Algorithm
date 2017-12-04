#include <iostream>
#include <fstream>

using namespace std;

int** loadGraph(string filePath, int& size)
{
    int src, dest;

    ifstream ifstream1(filePath);

    ifstream1 >> size;

    int** graph = new int*[size];

    for(int idx = 0; idx < size; ++idx)
    {
        graph[idx] = new int[size];
    }

    while(!ifstream1.eof())
    {
        ifstream1 >> src >> dest;

        graph[src - 1][dest - 1] = 1;
    }

    ifstream1.close();

    return graph;
}

int destructGraph(int** graph, const int size)
{
    for(int idx = 0; idx < size; ++idx)
    {
        delete[] graph[idx];
    }

    delete graph;

    return 0;
}

int main()
{
    int size;

    int** graph = loadGraph("sample1.txt", size);

    for(int i = 0; i < size; ++i)
    {
        for(int j = i + 1; j < size; ++ j)
        {
            if(graph[i][j] != graph[j][i])
            {
                cout << "Not a symmetric matrix." << endl;

                cout << "I: " << i << "  J: " << j << endl;
            }
        }
    }

    destructGraph(graph, size);

    return 0;
}