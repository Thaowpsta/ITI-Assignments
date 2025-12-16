#include <cstring>
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

class Queue
{
    int tail;
    int size;
    Employee *arr;

public:
    Queue(int cap = 10)
    {
        size = cap;
        arr = new Employee[size];
        tail = -1;
    }

    int EnQueue(Employee emp)
    {
        if (tail == size - 1)
            return 0;

        tail++;
        arr[tail] = emp;
        return 1;
    }

    Employee DeQueue()
    {
        Employee emp = arr[0];

        for (int i = 0; i < tail; i++)
        {
            arr[i] = arr[i + 1];
        }

        tail--;

        return emp;
    }

    void printAll()
    {
        for (int i = 0; i <= tail; i++)
        {
            cout << arr[i].getId() << " - " << arr[i].getName() << endl;
        }
    }
    
    ~Queue() {
        delete[] arr;
    }
};
// class Queue
// {
//     int top, end;
//     int size;
//     Employee *arr;

// public:
//     Queue(int cap = 10)
//     {
//         size = cap;
//         arr = new Employee[size];
//         top = 0;
//         end = -1; 
//     }

//     int EnQueue(Employee emp)
//     {
//         if (end == size - 1)
//             return 0;

//         end++;
//         arr[end] = emp;
//         return 1;
//     }

//     Employee DeQueue()
//     {
//         if (top > end)
//             return Employee();

//         Employee emp = arr[top];
//         top++;
//         return emp;
//     }

//     void printAll()
//     {
//         for (int i = top; i <= end; i++)
//         {
//             cout << arr[i].getId() << " - " << arr[i].getName() << endl;
//         }
//     }
// };


int main()
{
    Queue q(10);
    int choice;

    do
    {
        cout << "\nEnter choice:\n";
        cout << "1. Enqueue\n";
        cout << "2. Dequeue\n";
        cout << "3. Print All\n";
        cout << "4. Exit\n";

        cin >> choice;

        if (choice == 1)
        {
            Employee e = fillEmp();
            if (q.EnQueue(e))
                cout << "Employee Enqueued.\n";
        }

        else if (choice == 2)
        {
            Employee e = q.DeQueue();
            cout << "Dequeued: " << e.getId() << " - " << e.getName() << endl;
        }

        else if (choice == 3)
        {
            q.printAll();
        }

    } while (choice != 4);

    return 0;
}
