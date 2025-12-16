#include <cmath>
#include <iostream>
using namespace std;

int main(){

    //Read the 20 elements of double array sales from the keyboard
    double sales[20];

    for (int i = 0; i < sizeof(sales); i++)
    {
        cout << "Eneter salary for element " << i + 1 << ": ";
        cin >> sales[i];
    }


    // Add 1000 to each of the 75 elements of double array allowance.
    double allowance[75];
    for (int i = 0; i < sizeof(allowance); i++)
    {
        allowance[i] += 1000;
    }


    //Initialize the 50 elements of integer array numbers to zero
    int numbers[50] = {1, 2};

    
    //Print the 10 values of integer array GPA in column format.
    int GPA[10] = {4, 3, 5, 2, 4, 3, 5, 4, 3, 2};
    cout << "GPA values in column format: " << endl;
    for (int i = 0; i < sizeof(GPA); i++)
    {
        cout << GPA[i] << endl; 
    }
}