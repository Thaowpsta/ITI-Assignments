#include <cmath>
#include <iostream>
using namespace std;

float toYen(float dollars);
float toEuro(float dollars);

int main(){
    float dollars;
    cout << "Enter amount in dollars: ";
    cin >> dollars;

    cout << "Amount in Yen: " << toYen(dollars) << endl;
    cout << "Amount in Euro: " << toEuro(dollars) << endl;
}

float toYen(float dollars){
    return dollars * 118.87;
}

float toEuro(float dollars){
    return dollars * 0.92;
}