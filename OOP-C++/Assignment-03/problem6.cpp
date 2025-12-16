#include <cmath>
#include <iostream>

using namespace std;

int sumOfDigits(int number);

int main(){
    int digit, sum = 0;

    cout << "Enter a Number to calculate its sum of digits: ";
    cin >> digit;

    sum = sumOfDigits(digit);

    cout << "Sum of digits: " << sum << endl;
    
}

int sumOfDigits(int number){
    int sum = 0;
    while (number != 0)
    {
        sum += number % 10;
        number /= 10;
    }
    return sum;
}