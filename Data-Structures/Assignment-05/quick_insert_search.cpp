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

void printEmployee(Employee emp)
{
    cout << "Employee ID : " << emp.getId() << endl;
    cout << "Employee Name : " << emp.getName() << endl;
}

Employee fillEmp()
{
    Employee emp;
    int id;
    char name[20];
    int grade[5];
    cout << "Enter ID : ";
    cin >> id;
    emp.setId(id);
    cout << "Enter Name : ";
    cin >> name;
    emp.setName(name);

    return emp;
}

void Quick_sort(Employee ar[], int start, int end);
void Insertion_sort(Employee ar[], int start, int end);
int Partition(Employee ar[], int start, int end);
int Binary_search_ID(Employee ar[], int start, int end, Employee key);
int Binary_search_Name(Employee ar[], int start, int end, Employee key);

int main()
{
    Employee arr[5];
    int size = 0;
    int choice;

    do
    {
        cout << "\n========= MENU =========\n";
        cout << "1. Fill Employee\n";
        cout << "2. Print Employees\n";
        cout << "3. Sort by ID (Insertion Sort)\n";
        cout << "4. Sort by Name (Quick Sort)\n";
        cout << "5. search by Name\n";
        cout << "6. search by ID\n";
        cout << "7. Exit\n";
        cout << "========================\n";
        cout << "Enter your choice: ";
        cin >> choice;

        if (choice == 1)
        {
            if (size < 5)
            {
                cout << "\nEnter employee data:\n";
                arr[size] = fillEmp();
                size++;
                cout << "Employee added! Current count = " << size << endl;
            }
            else
            {
                cout << "\nArray is FULL! Cannot add more employees.\n";
            }
        }

        else if (choice == 2)
        {
            if (size == 0)
            {
                cout << "No employees to print. Please fill first.\n";
            }
            else
            {
                cout << "\nEmployee Data:\n";
                for (int i = 0; i < size; i++)
                {
                    printEmployee(arr[i]);
                    cout << "-------------------\n";
                }
            }
        }

        else if (choice == 3)
        {
            if (size == 0)
            {
                cout << "Please fill employees first.\n";
            }
            else
            {
                Insertion_sort(arr, 0, size);
                cout << "Employees sorted by ID.\n";
            }
        }

        else if (choice == 4)
        {
            if (size == 0)
            {
                cout << "Please fill employees first.\n";
            }
            else
            {
                Quick_sort(arr, 0, size - 1);
                cout << "Employees sorted by Name.\n";
            }
        }

        else if (choice == 5)
        {
            if (size == 0)
            {
                cout << "Please fill employees first.\n";
            }
            else
            {
                Insertion_sort(arr, 0, size);

                char name[30];
                cout << "Please write the Name to search.\n";
                cin >> name;

                Employee key;
                key.setName(name);

                int found = Binary_search_Name(arr, 0, size - 1, key);

                if (found == -1)
                {
                    cout << "Employees Not found.\n";
                }
                else
                    cout << "Employees Found in location " << found << endl;
            }
        }

        else if (choice == 6)
        {
            if (size == 0)
            {
                cout << "Please fill employees first.\n";
            }
            else
            {
                Insertion_sort(arr, 0, size);

                int id;
                cout << "Please write the ID to search.\n";
                cin >> id;

                Employee key;
                key.setId(id);

                int found = Binary_search_ID(arr, 0, size - 1, key);

                if (found == -1)
                {
                    cout << "Employees Not found.\n";
                }
                else
                    cout << "Employees Found in location " << found << endl;
            }
        }

    } while (choice != 7);

    cout << "Exiting program...\n";
    return 0;
}

// sort by Name
void Quick_sort(Employee ar[], int start, int end)
{

    int loc;
    if (end > start)
    {
        loc = Partition(ar, start, end);
        Quick_sort(ar, start, loc - 1);
        Quick_sort(ar, loc + 1, end);
    }
}

// sort by Name
int Partition(Employee ar[], int start, int end)
{
    Employee pivot = ar[start];
    int low = start + 1;
    int high = end;

    while (low <= high)
    {
        while ( strcmp(ar[low].getName(), pivot.getName()) < 0)
            low++;

        while (strcmp(ar[high].getName(), pivot.getName()) > 0)
            high--;

        if (low < high)
            swap(ar[low], ar[high]);
    }

    swap(ar[start], ar[high]);
    return high;
}

// sort by ID
void Insertion_sort(Employee ar[], int start, int end)
{
    Employee key;
    int j;
    for (int i = start; i < end; i++)
    {
        key = ar[i];
        j = i - 1;

        while (j >= 0 && ar[j].getId() > key.getId())
        {
            ar[j + 1] = ar[j];
            j--;
        }
        ar[j + 1] = key;
    }
}

// sort by ID
int Binary_search_ID(Employee ar[], int start, int end, Employee key)
{
    int loc = -1, mid;

    while (start <= end && loc == -1)
    {
        mid = (start + end) / 2;

        if (ar[mid].getId() == key.getId())
        {
            loc = mid;
        }
        else if (ar[mid].getId() > key.getId())
        {
            end = mid - 1;
        }
        else
        {
            start = mid + 1;
        }
    }
    return loc;
}

// sort by Name
int Binary_search_Name(Employee ar[], int start, int end, Employee key)
{
    int loc = -1, mid;

    while (start <= end && loc == -1)
    {
        mid = (start + end) / 2;

        if (strcmp(ar[mid].getName(), key.getName()) == 0)
        {
            loc = mid;
        }
        else if (strcmp(ar[mid].getName(), key.getName()) > 0)
        {
            end = mid - 1;
        }
        else
        {
            start = mid + 1;
        }
    }
    return loc;
}