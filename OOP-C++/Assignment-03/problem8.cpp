#include <cmath>
#include <iostream>
using namespace std;

unsigned long long int fibonacci(unsigned int n);
int largest_fib_number();

int main()
{
    int n;
    cout << "Enter a positive integer: ";
    cin >> n;
    cout << "Fibonacci(" << n << ") = " << fibonacci(n) << endl;

    int largest_n = largest_fib_number();
    cout << "The largest Fibonacci number that can be printed on my system is Fibonacci(" << largest_n << ")" << endl;
}

// A non recursive function fibonacci(n) that calculates the nth Fibonacci number
unsigned long long int fibonacci(unsigned int n)
{
    unsigned long long int prev = 0, curr = 1, next;

    if (n == 0)
        return 0;

    if (n == 1)
        return 1;

    for (int i = 2; i <= n; i++)
    {
        next = prev + curr;
        prev = curr;
        curr = next;
    }
    return curr;
}

// Determine the largest Fibonacci number that can be printed on my system.
int largest_fib_number()
{
    unsigned long long int prev = 0, curr = 1, next;
    int n = 1;
    bool flag = true;

    while (flag)
    {
        next = prev + curr;

        if (next < curr)
        {
            flag = false;
        }

        prev = curr;
        curr = next;
        n++;
    }
    return n - 1;
}