#include <cmath>
#include <iostream>
using namespace std;

float largestNum(float a, float b, float c);
bool IsRightTriangle(float a, float b, float c);

int main(){

    float a, b, c;
    cout << "Enter side a: ";
    cin >> a;
    cout << "Enter side b: ";
    cin >> b;
    cout << "Enter side c: ";
    cin >> c;

    cout << IsRightTriangle(a, b, c) << endl;
}

float largestNum(float a, float b, float c)
{
    if (a > b && a > c)
    {
        return a;
    }
    else if (b > a && b > c)
    {
        return b;
    }
    else
    {
        return c;
    }
}

bool IsRightTriangle(float a, float b, float c)
{
    int largest;
    largest = largestNum(a, b, c);
    if (largest == a)
    {
        if (sqrt( (b * b) + (c * c))  == a)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    else if (largest == b)
    {
        if (sqrt( (a * a) + (c * c))  == b)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    else if(largest == c)
    {
        if (sqrt( (b * b) + (a * a))  == c)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    return false;
}

