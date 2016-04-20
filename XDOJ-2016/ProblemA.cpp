//
// Created by cfwloader on 4/18/16.
//
#include <iostream>

#include <string>

using namespace std;

string addComplexity(string a, string b)
{

    static char buffer[255];

    unsigned int aReality, aInscriber, bReality, bInscriber;

    unsigned int counter = 0, index;

    for(index = 0; a[index] != '+'; ++index)
    {
        counter = counter * 10 + a[index] - '0';
    }

    aReality = counter;

    counter = 0;

    ++index;

    for(;a[index] != 'i'; ++index)
    {
        counter = counter * 10 + a[index] - '0';
    }

    aInscriber = counter;

    counter = 0;

    for(index = 0; b[index] != '+'; ++index)
    {
        counter = counter * 10 + b[index] - '0';
    }

    bReality = counter;

    counter = 0;

    ++index;

    for(;b[index] != 'i'; ++index)
    {
        counter = counter * 10 + b[index] - '0';
    }

    bInscriber = counter;

    sprintf(buffer, "%d+%di", aReality + bReality, aInscriber + bInscriber);

    return string(buffer);

}

//int main()
//{
//
//    string a, b;
//
//    while(cin >> a >> b)
//    {
//        cout << addComplexity(a, b) << endl;
//    }
//
//    return 0;
//}
