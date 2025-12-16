#include <cmath>
#include <iostream>
#define base_salary 200
#define bounes_Rate 0.09
using namespace std;

int main(){
    int first_set[10], second_set[10], common_set[10], common_count = 0;
    bool is_added;

    cout << "Enter 10 integers for the first set: " << endl;
    for (int i = 0; i < 10; i++){
        cin >> first_set[i];
    }

    cout << "Enter 10 integers for the second set: " << endl;
    for (int i = 0; i < 10; i++){
        cin >> second_set[i]; 
    }

    for (int i = 0; i < 10; i++)
    {
        for (int j = 0; j < 10; j++)
        {
            if(first_set[i] == second_set[j]){
                is_added = false;
                for(int k = 0; k < common_count; k++){
                    if (first_set[i] == common_set[k])
                    {
                        is_added = true;
                    }
                    
                }
                if (!is_added)
                {
                    common_set[common_count] = first_set[i];
                    common_count++;
                }
                
            }
        }
        
        
    }

    if (common_count > 0)
    {
        cout << "The common elements are: {";
        for (int i = 0; i < common_count; i++)
        {
            if (i < (common_count - 1))
            {
            cout << common_set[i] << ", ";
            }
            else
            {
                cout << common_set[i] << "}" << endl;
            } 
        }
    }
    else
    {
        cout << "No common elements." << endl;
    }
}