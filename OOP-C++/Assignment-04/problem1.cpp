#include <iostream>
using namespace std;

int main()
{
    int sales_product[5][4];
    int total_sales = 0;

    // Input sales data
    for (int i = 0; i < 5; ++i)
    {
        cout << "Enter sales for Product " << (i + 1) << " by 4 salespersons: ";
        for (int j = 0; j < 4; ++j)
        {
            cin >> sales_product[i][j];
        }
    }


    // print table contain sales data and totals
    cout << "Product\\Salesperson\t1\t2\t3\t4\tTotal\n";
    cout << "--------------------------------------------------------------\n";
    for (int i = 0; i < 6; ++i)
    {
        int product_total = 0;
        int salesperson_total = 0;

        //total for each salesperson (last row)
        if (i == 5)
        {
            cout << "Total\t\t\t";
            for (int j = 0; j < 4; ++j)
            {
                for (int i = 0; i < 5; ++i)
                {
                    salesperson_total += sales_product[i][j];
                }
                cout << salesperson_total << "\t";
                salesperson_total = 0;
            }
        }
        else
        {
            //each product row
            cout << "Product " << (i + 1) << "\t\t";
            for (int j = 0; j < 4; ++j)
            {
                cout << sales_product[i][j] << "\t";
                product_total += sales_product[i][j];
            }
            cout << product_total << "\n";
        }
    }
}