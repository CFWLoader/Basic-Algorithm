#include <iostream>
#include <string>

using namespace std;

//int main()
//{
//
//    string a, b, result;
//
//    char presented[26];
//
//    int size, count;
//
//    while(cin >> a >> b)
//    {
//        count = 0;
//
//        for(int index = 0; index < 26; ++index)
//        {
//            presented[index] = 0;
//        }
//
//        size = b.size();
//
//        for(int index = 0; index < size; ++index)
//        {
//            if(!presented[b[index] - 'a'])
//            {
//                presented[b[index] - 'a'] = 1;
//            }
//        }
//
//        size = a.size();
//
//        for(int index = 0; index < size; ++index)
//        {
//            if(!presented[a[index] - 'a'])
//            {
//                printf("%c", a[index]);
//
//                ++count;
//            }
//        }
//
//        if(count == 0)
//        {
//            printf("EMPTY\n");
//        }
//        else
//        {
//            printf("\n");
//        }
//    }
//
//    return 0;
//}