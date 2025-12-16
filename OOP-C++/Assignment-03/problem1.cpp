#include <cmath>
#include <iostream>
#include <iomanip>
#define MIN_FEES 25.0
#define TAX_SERVICE 0.5
#define ADDITIONAL_CHARGE 5
using namespace std;

float calculateCharges(int hours);

int main(){
    float car1 = calculateCharges(12);
    float car2 = calculateCharges(34);
    float car3 = calculateCharges(48);
    float totalFees = car1 + car2 + car3;
    int totalHours = 12 + 34 + 48;
    
    cout << "Car\t\tHours\t\tCharge" << endl;
    cout << "1\t\t12\t\t" << fixed << setprecision(2) << car1 << endl;
    cout << "2\t\t34\t\t" << fixed << setprecision(2) << car2 << endl;
    cout << "3\t\t48\t\t" << fixed << setprecision(2) << car3 << endl;
    cout << "TOTAL\t\t" << totalHours << "\t\t" << fixed << setprecision(2) << totalFees << endl;
    
    return 0;
}

float calculateCharges(int hours){
    float fees;
    if (hours <= 8)
    {
        fees = 25;
    }
    else if (hours <= 24){
        fees = MIN_FEES + (TAX_SERVICE * hours) + (ADDITIONAL_CHARGE * (hours - 8));
        fees > 50 ? fees = 50 : fees = fees;
    }
    else{
        int days = ceil(hours / 24.0);
        fees = (days * 50) + (TAX_SERVICE * hours);
    }
    return fees;
}