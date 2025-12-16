#include <iostream>
using namespace std;

class Parent 
{
    protected:
        int x;
    public:
        Parent(int m) { x = m; }
        // This makes the global function 'display' a friend of Parent
        friend void display(); 
};

class Child : public Parent 
{
    private:
        int y;
    public:
        Child(int m, int n) : Parent(m) 
        { 
            y = n; 
        }
};

void display() 
{
    Child c(3,4);
    
    // c.x works because display() is a friend of Parent.
    // c.y FAILS because display() is NOT a friend of Child.
    cout << "x=" << c.x << "y=" << c.y; // Line 1
}

int main() 
{
    display();
    return 0;
}