#include <iostream>
using namespace std;


class Employee
{
    int id;
    char name[20];

public:
    Employee()
    {
        id = 0;
        strcpy(name, "No Name");
    }
    Employee(int i, char *n)
    {
        id = i;
        strcpy(name, n);
    }
    void setId(int id)
    {
        this->id = id;
    }
    int getId()
    {
        return id;
    }
    void setName(char *n)
    {
        strcpy(name, n);
    }
    char *getName()
    {
        return name;
    }
};

 void printEmployee( Employee emp){
    cout<<"Employee ID : " << emp.getId()<<endl;
    cout<<"Employee Name : " << emp.getName()<<endl;
   
   
 }

Employee fillEmp(){
    Employee emp;
    int id; 
    char name[20];
    int grade[5];
    cout<<"Enter ID : ";
    cin>> id;
    emp.setId(id);
    cout<< "Enter Name : ";
    cin>> name;
    emp.setName(name);

    
    return emp;

}

void Bubble_sort(Employee ar[], int size);
void Merge_sort(Employee ar[], int start, int end);
void Merge(Employee ar[], int start, int mid, int end);

int main() {
    Employee arr[5];
    int size = 0;      
    int choice;

    do {
        cout << "\n========= MENU =========\n";
        cout << "1. Fill Employee\n";
        cout << "2. Print Employees\n";
        cout << "3. Sort by ID (Bubble Sort)\n";
        cout << "4. Sort by Name (Merge Sort)\n";
        cout << "5. Exit\n";
        cout << "========================\n";
        cout << "Enter your choice: ";
        cin >> choice;

        if (choice == 1) {
            if (size < 5) {
                cout << "\nEnter employee data:\n";
                arr[size] = fillEmp();  
                size++;                 
                cout << "Employee added! Current count = " << size << endl;
            } else {
                cout << "\nArray is FULL! Cannot add more employees.\n";
            }
        }

        else if (choice == 2) {
            if (size == 0) {
                cout << "No employees to print. Please fill first.\n";
            } else {
                cout << "\nEmployee Data:\n";
                for (int i = 0; i < size; i++) {
                    printEmployee(arr[i]);
                    cout << "-------------------\n";
                }
            }
        }

        else if (choice == 3) {
            if (size == 0) {
                cout << "Please fill employees first.\n";
            } else {
                Bubble_sort(arr, size);
                cout << "Employees sorted by ID.\n";
            }
        }

        else if (choice == 4) {
            if (size == 0) {
                cout << "Please fill employees first.\n";
            } else {
                Merge_sort(arr, 0, size - 1);
                cout << "Employees sorted by Name.\n";
            }
        }

    } while (choice != 5);

    cout << "Exiting program...\n";
    return 0;
}

void Bubble_sort(Employee ar[], int size){

    int i, j, swapped = 1;
    Employee temp;

    for ( i = 0; i < size - 1 && swapped; i++)
    {
        swapped = 0;
        for ( j = 0; j < size - 1 - i; j++)
        {
            if (ar[j].getId() > ar[j + 1].getId())
            {
                temp = ar[j];
                ar[j] = ar[j + 1];
                ar[j + 1] = temp;
                swapped = 1;
            }
            
        }
        
    }
    
}

void Merge_sort(Employee ar[], int start, int end)
{
    if (start < end)
    {
        int mid = (start + end) / 2;

        Merge_sort(ar, start, mid);
        Merge_sort(ar, mid + 1, end);

        Merge(ar, start, mid, end);
    }
}

void Merge(Employee ar[], int start, int mid, int end)
{
    int list1, list2, temp_itrator;
    Employee temp[100];

    list1 = start;
    list2 = mid + 1;
    temp_itrator = start;

    while (list1 <= mid && list2 <= end)
    {
        if (strcmp(ar[list1].getName(), ar[list2].getName()) > 0)
        {
            temp[temp_itrator] = ar[list2];
            list2++;
        }
        else
        {
            temp[temp_itrator] = ar[list1];
            list1++;
        }
        temp_itrator++;
    }

    while (list1 <= mid)
    {
        temp[temp_itrator] = ar[list1];
        list1++;
        temp_itrator++;
    }

    while (list2 <= end)
    {
        temp[temp_itrator] = ar[list2];
        list2++;
        temp_itrator++;
    }

    for (temp_itrator = start; temp_itrator <= end; temp_itrator++)
    {
        ar[temp_itrator] = temp[temp_itrator];
    }
}
