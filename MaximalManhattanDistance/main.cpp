#include <iostream>
#include<cstdio>
#include<cstring>
#include<algorithm>
#include<cmath>
#include<iomanip>

using namespace std;
const double INF = 1e200;
const int d=5;
double a[d];
double maxx[1<<d],minn[1<<d];

void insert()
{
    for(int i=0; i<1<<d; i++)
    {
        double now=0;
        for(int j=0; j<d; j++)
        {
            if((1<<j)&i)now+=a[j];
            else now-=a[j];
        }
        maxx[i]=max(maxx[i],now);
        minn[i]=min(minn[i],now);
    }
}

void init()
{
    for(int i=0; i<1<<d; i++)
    {
        maxx[i]=-INF;
        minn[i]=INF;
    }
}

int main()
{
    int N;
    while(~scanf("%d",&N))
    {
        init();
        for(int i=0; i<N; i++)
        {
            for(int j=0; j<d; j++)
                scanf("%lf",a+j);
            insert();
        }
        double ans=-INF;
        for(int i=0; i<1<<d; i++)
            ans=max(ans,maxx[i]-minn[i]);
        printf("%.2f\n",ans);
    }
    return 0;
}