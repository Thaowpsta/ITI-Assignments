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

struct Node
{
    Employee emp;
    Node *pPrev;
};

class Stack
{
    Node *tos;

public:
    Stack()
    {
        tos = NULL;
    }

    int Push(Employee d)
    {
        int pushed = 0;
        Node *ptr = new Node;

        if (ptr)
        {
            ptr->emp = d;
            ptr->pPrev = tos;
            pushed = 1;
            tos = ptr;
        }
        return pushed;
    }

    Employee pop()
    {
        if (tos != NULL)
        {
            Node *ptr = tos;
            Employee e = ptr->emp;

            tos = ptr->pPrev;

            delete ptr;
            return e;
        }
    }

    void printStack()
    {
        Node *ptr = tos;
        
        while (ptr)
        {
            cout << ptr->emp.getId() << " - " << ptr->emp.getName() << endl;
            ptr = ptr->pPrev;
        }
    }
};
int main()
{
    Stack s;
    Employee emp;
    int choice;

    do
    {
        cout << "\nEnter choice:\n";
        cout << "1. Push\n";
        cout << "2. Pop\n";
        cout << "3. Print All\n";
        cout << "4. Exit\n";

        cin >> choice;

        if (choice == 1)
        {
            Employee e = fillEmp();
            s.Push(e);
            cout << "Employee pushed.\n";
        }

        else if (choice == 2)
        {
            Employee p = s.pop();
            cout << "Popped: " << p.getId() << " - " << p.getName() << endl;
        }

        else if (choice == 3)
        {
            s.printStack();
        }

    } while (choice != 4);

    return 0;
}
