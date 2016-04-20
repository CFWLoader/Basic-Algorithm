#include <iostream>

using namespace std;

int lastAttack(int playerA, int playerB, int bossHealth)
{
    int finalHealth = bossHealth % (playerA + playerB);

    if(finalHealth == 0)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

//int main()
//{
//
//    int playerA, playerB, bossHealth, result;
//
//    while(cin >> playerA >> playerB >> bossHealth)
//    {
//        result = lastAttack(playerA, playerB, bossHealth);
//
//        if(result == 0)
//        {
//            cout << "wanshen" << endl;
//        }
//        else
//        {
//            cout << "light" << endl;
//        }
//    }
//
//    return 0;
//}