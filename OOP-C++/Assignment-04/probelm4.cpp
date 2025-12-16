#include <iostream>
#include <cctype>
using namespace std;

int main()
{
    char s[100];
    cout << "Enter a string: ";
    cin.getline(s, 100); // allows spaces

    for (int i = 0; s[i] != '\0'; i++)
    {
        if (i % 2 == 0)
            s[i] = toupper(s[i]);
        else
            s[i] = tolower(s[i]);
    }

    cout << "Alternate case: " << s << endl;
}
