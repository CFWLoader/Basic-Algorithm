//
// Created by cfwloader on 4/19/16.
//
#include <iostream>
#include <algorithm>
#include <string>
#include <functional>

using namespace std;

using namespace std::placeholders;

bool equals(char a, char b)
{
    return a == b;
}

string eraseCharacters(string& a, string& b)
{

    function<bool(char)> equals_bind;

    char presented[26];

    for(int index = 0; index < 26; ++index)
    {
        presented[index] = 0;
    }

    for(string::iterator iter = b.begin(); iter != b.end(); ++iter)
    {
        if(!presented[*iter - 'a'])
        {
            presented[*iter - 'a'] = 1;
        }
    }

    for(int index = 0; index < 26; ++index)
    {
        if(presented[index])
        {
            equals_bind = std::bind(equals, _1, index + 'a');

            a.erase(remove_if(a.begin(), a.end(), equals_bind), a.end());
        }
    }

    return a;
}

//int main()
//{
//
//    string a, b, result;
//
//    while(cin >> a >> b)
//    {
//        result = eraseCharacters(a, b);
//
//        if(result.size() == 0)
//        {
//            cout << "EMPTY" << endl;
//        }
//        else
//        {
//            cout << result << endl;
//        }
//    }
//
//    return 0;
//}
