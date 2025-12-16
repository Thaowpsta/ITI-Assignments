#include <cmath>
#include <iostream>

using namespace std;

int power(int base, int exp);

int main(){
    cout << "The value of 2 to the power 3 = " << power(2,3) << endl;
}

// int power(int base, int exp){
//     int result = 1;
//     for(int i = 0; i < exp; i++){
//         result *= base;
//     }
//     return result;
// }

int power(int base, int exp){
    int result = 1;
    if (exp == 0)
    {
        return 1;
    }else {
        return base * power(base, exp - 1);  
    }

    return result;
}