#include <iostream>
#include <cctype>
using namespace std;

int main()
{
    char str[6];
    int sum = 0;

    for (int i = 0; i < 6; i++)
    {

        cout << "Enter string " << (i + 1) << ": ";
        cin >> str[i];

        sum += str[i] - 48;
        
    }

    cout << "Sum = " << sum << endl;
}