#include <iostream>
using namespace std;

#include <cstring>

class Base{
    protected:
    int z;

    public:
    Base(){
        z = 0;
        // z = 1;
    }
    Base(int m){
        z = m;
    }
    void setZ(int m){
        z = m;
    }
    int getZ(){
        return z;
    }
};

class Base1: virtual public Base{
    protected:
    int x;
    public:
    Base1(){
        x = 0;
    }
    Base1(int m){
        x = m;
    }
    void setX(int m){
        x = m;
    }
    int getX(){
        return x;
    }
};

class Base2: virtual public Base{
    protected:
    int y;
    public:
    Base2(){
        y = 0;
    }
    Base2(int m){
        y = m;
    }
    void setY(int m){
        y = m;
    }
    int getY(){
        return y;
    }
};

class Derived : public Base1, public Base2
{
    public:
    Derived(){}

    Derived(int m, int n): Base1(m), Base2(n){}

    int prodect(){
        return x * y * z;
    }
};

int main(){
    Derived drv(3,4);

    cout << drv.prodect() << endl;
}