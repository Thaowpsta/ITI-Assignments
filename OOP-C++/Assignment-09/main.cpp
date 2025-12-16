#include <iostream>
using namespace std;

#include <cstring>

class Person
{

protected:
    int id;
    char name[20];

public:
    Person()
    {
        id = 0;
        strcpy(name, "No Name");
    }
    Person(int id, char n[])
    {
        this->id = id;
        strcpy(name, n);
    }

    void setName(char n[])
    {
        strcpy(name, n);
    }

    void setId(int id)
    {
        this->id = id;
    }

    char *getName()
    {
        return name;
    }

    int getId()
    {
        return id;
    }

    void print()
    {
        cout << "The person id: " << id << " with name: " << name << endl;
    }
};

class Student : public Person
{
    int grades[5];

public:
    void setGrades(int n[5])
    {
        for (int i = 0; i < 5; i++)
        {
            grades[i] = n[i];
        }
    }

    int *getGrades()
    {
        return grades;
    }

    Student()
    {
        for (int i = 0; i < 5; i++)
        {
            grades[i] = 0;
        }
    };
    Student(int id, char n[], int g[]) : Person(id, n)
    {
        for (int i = 0; i < 5; i++)
        {
            grades[i] = g[i];
        }
    };
    void print()
    {
        cout << "The Student id: " << id << " with name: " << name << " and grades: " << endl;
        for (int i = 0; i < 5; i++)
        {
            cout << "Grade " << i + 1 << "is: " << grades[i] << endl;
        }
    }
};

class Instructor : public Person
{
    char subject[20];

public:
    Instructor()
    {
        strcpy(subject, "No Subject");
    }
    Instructor(int id, char n[], char sub[]) : Person(id, n)
    {
        strcpy(subject, sub);
    }
    void setSubject(char s[])
    {
        strcpy(subject, s);
    }
    char *getSubject()
    {
        return subject;
    }

    void print()
    {
        cout << "The Instructor id: " << id << " with name: " << name << " and subject: " << subject << endl;
    }

};

void fillStd(Student &std);
void printStd(Student std);

int main()
{
    int grades[5] = {20, 30, 40, 50, 60};
    Student s1;
    s1.print();

    Student s2(1, "Thaowpsta", grades);
    s2.print();

    Instructor s3;
    s3.print();

    Instructor s4(2, "Nardeen", "Data Analysis");
    s4.print();
}