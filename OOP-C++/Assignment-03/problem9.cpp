#include <cmath>
#include <iostream>
#define base_salary 200
#define bounes_Rate 0.09
using namespace std;

int main()
{
    int salary_ranges[9] = {0}, range_index;
    double salary, gross_sales;
    bool flag = true;

    do
    {
        cout << "Enter the gross sales (-1 to end): " << endl;
        cin >> gross_sales;

        if (gross_sales == -1)
        {
            flag = false;
        }

        salary = base_salary + (bounes_Rate * gross_sales);

        if (salary >= 200 && salary <= 299)
        {
            range_index = 0;
        }
        else if (salary >= 300 && salary <= 399)
        {
            range_index = 1;
        }
        else if (salary >= 400 && salary <= 499)
        {
            range_index = 2;
        }
        else if (salary >= 500 && salary <= 599)
        {
            range_index = 3;
        }
        else if (salary >= 600 && salary <= 699)
        {
            range_index = 4;
        }
        else if (salary >= 700 && salary <= 799)
        {
            range_index = 5;
        }
        else if (salary >= 800 && salary <= 899)
        {
            range_index = 6;
        }
        else if (salary >= 900 && salary <= 999)
        {
            range_index = 7;
        }
        else if (salary >= 1000)
        {
            range_index = 8;
        }

        salary_ranges[range_index]++;
    } while (flag);

    cout << "Number of salespeople in each salary range: " << endl;
    cout << "$200-299: " << salary_ranges[0] << endl;
    cout << "$300-399: " << salary_ranges[1] << endl;
    cout << "$400-499: " << salary_ranges[2] << endl;
    cout << "$500-599: " << salary_ranges[3] << endl;
    cout << "$600-699: " << salary_ranges[4] << endl;
    cout << "$700-799: " << salary_ranges[5] << endl;
    cout << "$800-899: " << salary_ranges[6] << endl;
    cout << "$900-999: " << salary_ranges[7] << endl;
    cout << "$1000 and over: " << salary_ranges[8] << endl;
}
