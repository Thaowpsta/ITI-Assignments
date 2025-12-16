#include <cmath>
#include <iostream>
using namespace std;

float HypotenuseCalculator(float x, float y);

int main(){
    float a, b;
    cout << "Enter side a: ";
    cin >> a;
    cout << "Enter side b: ";
    cin >> b;

    float hypotenuse = HypotenuseCalculator(a, b);
    cout << "Hypotenuse: " << hypotenuse << endl;
    return 0;
}

float HypotenuseCalculator(float x,float y){
    return sqrt((x * x) + (y * y));
};