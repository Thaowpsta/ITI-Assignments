#include <cmath>
#include <iostream>
using namespace std;

bool IsTriangle(float a, float b, float c);
float TriangleArea(float a, float b, float c);
float largestNum(float a, float b, float c);

int main()
{
    float a, b, c;
    cout << "Enter side a: ";
    cin >> a;
    cout << "Enter side b: ";
    cin >> b;
    cout << "Enter side c: ";
    cin >> c;
    
    if (IsTriangle(a, b, c))
    {
        TriangleArea(a, b, c);
        cout << "Area: " << TriangleArea(a, b, c) << endl;
    }
    else
    {
        cout << "Not a triangle" << endl;
    }
    
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

bool IsTriangle(float a, float b, float c)
{
    int largest;
    largest = largestNum(a, b, c);
    if (largest == a)
    {
        if ((b + c) > a)
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
        if ((a + c) > b)
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
        if ((a + b) > c)
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

float TriangleArea(float a, float b, float c)
{
    float s = (a + b + c) / 2;
    return sqrt(s * (s - a) * (s - b) * (s - c));
}

