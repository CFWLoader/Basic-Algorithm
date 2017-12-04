#include <iostream>
#include <fstream>

using namespace std;

int** loadGraph(string filePath, int& size);

int destructGraph(int** graph, const int size);

void dfsEntry(int, int**, const int);

void dfs(int u, int**, const int, int*, int*, int*, int* parent);

int main()
{
    int size;

    int** graph = loadGraph("sample2.txt", size);

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

    dfsEntry(5, graph, size);

    destructGraph(graph, size);

    return 0;
}

int** loadGraph(string filePath, int& size)
{
    int src, dest;

    ifstream ifstream1(filePath);

    ifstream1 >> size;

    int** graph = new int*[size];

    for(int idx = 0; idx < size; ++idx)
    {
        graph[idx] = new int[size];

        for(int jIdx = 0; jIdx < size; ++jIdx)
        {
            graph[idx][jIdx] = 0;
        }
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

void dfsEntry(int u, int** graph, const int size)
{
    int* dfn = new int[size], *back = new int[size], *visted = new int[size], *parent = new int[size];

    for(int idx = 0; idx < size; ++ idx)
    {
        dfn[idx] = back[idx] = parent[idx] = -1;
        visted[idx] = 0;
    }

    dfs(u, graph, size, visted, dfn, back, parent);

    delete[] visted;

    delete[] dfn;

    delete[] parent;

    delete[] back;
}

void dfs(int u, int** graph, const int size, int* visited, int* dfn, int* back, int* parent)
{
    static int counter = 0;

    int children = 0;

    ++counter;

    dfn[u] = back[u] = counter;

    visited[u] = 1;

    for(int idx = 0; idx < size; ++idx)
    {
        if(u == idx or graph[u][idx] == 0)
        {
            continue;
        }

        if(!visited[idx])
        {
            ++children;

            parent[idx] = u;

            dfs(idx, graph, size, visited, dfn, back, parent);

            back[u] = min(back[u], back[idx]);

            if(parent[u] == -1 and children > 1)
            {
                cout << "Articulation Point: " << char('A' + u) << endl;
            }
            else if(parent[u] != -1 and back[idx] >= dfn[u])
            {
                cout << "Articulation Point: " << char('A' + u) << endl;
            }
        }
        else if(idx != parent[u])
        {
            back[u] = min(back[u], dfn[idx]);
        }
    }
}