#include <iostream>
using namespace std;

struct student
{
    int id;
    char name[20];
    float grade[5];
};

student fillStd();
float sumOfGrades(float grades[5]);
void printStd(student std);

int main()
{
    // student std1;

    // std1 = fillStd();
    // printStd(std1);

    // student fiveStds[5];

    // for (int i = 0; i < 5; i++)
    // {
    //     cout << "Student Number " << i + 1 << endl;
    //     fiveStds[i] = fillStd();
    //     // printStd(fiveStds[i]);
    // }

    // for (int i = 0; i < 5; i++)
    // {
    //     cout << "The data of Student Number " << i + 1 << endl;
    //     printStd(fiveStds[i]);
    // }

    int size;
    cout << "Enter the number of students: " << endl;
    cin >> size;
    student *pStd;
    // student *pp;
    pStd = new student[size];

    if (pStd)
    {
        // pp = pStd;
        for (int i = 0; i < size; i++)
        {
            cout << "Student Number " << i + 1 << endl;
            pStd[i] = fillStd();
        }
        // pStd = pp;
        for (int i = 0; i < size; i++)
        {
            cout << "The data of Student Number " << i + 1 << endl;
            printStd(pStd[i]);
        }

        delete pStd;
    }else{
        cout << "Can't reserve place" << endl;
    }
}

student fillStd()
{
    student std;

    cout << "Enter Student name:";
    cin >> std.name;
    cout << "Enter Student id:";
    cin >> std.id;
    for (int i = 0; i < 5; i++)
    {
        cout << "Enter Student grade for subject" << i + 1 << ":" << endl;
        cin >> std.grade[i];
    }
    return std;
}

float sumOfGrades(float grades[5])
{
    float sum = 0;
    for (int i = 0; i < 5; i++)
    {
        sum += grades[i];
    }
    return sum;
}

void printStd(student std)
{
    cout << "The grade of student id: " << std.id << " with name: " << std.name << " is: " << sumOfGrades(std.grade) << endl;
    // return std;
}
