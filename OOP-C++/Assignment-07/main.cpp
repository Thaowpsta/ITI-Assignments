#include <iostream>
using namespace std;

#include <cstring>
class Student
{
private:
    int id;
    char name[20];
    int grades[5];
    static int count;
    static char schoolName[20];

public:
    void setName(char n[])
    {
        strcpy(name, n);
    }

    void setId(int id)
    {
        this->id = id;
    }

    void setGrades(int n[5])
    {
        for (int i = 0; i < 5; i++)
        {
            grades[i] = n[i];
        }
    }

    char *getName()
    {
        return name;
    }

    int getId()
    {
        return id;
    }

    int *getGrades()
    {
        return grades;
    }

    static int getCount()
    {
        return count;
    }

    static char *getSchoolName()
    {
        return schoolName;
    }

    static void setSchoolName(char n[])
    {
        strcpy(schoolName, n);
    }

    Student()
    {
        id = 0;
        strcpy(name, "No name");

        for (int i = 0; i < 5; i++)
        {
            grades[i] = 0;
        }

        count++;
    };
    Student(char n[], int g[])
    {
        strcpy(name, n);

        for (int i = 0; i < 5; i++)
        {
            grades[i] = g[i];
        }

        count++;
    }

    ~Student()
    {
        count--;
    }
};

int Student::count = 0;
char Student::schoolName[20] = "ITI";

void fillStd(Student &std);
// float sumOfGrades(float grades[5]);
void printStd(Student std);

int main()
{
    int grades[5] = {20, 30, 40, 50, 60};
    Student s1("Thaowpsta", grades);

    Student s;
    fillStd(s);
    cout << "Count of Students: " << Student::getCount() << endl;
    printStd(s1);
    cout << "Count of Students: " << Student::getCount() << endl;

    printStd(s);

    cout << "Count of Students: " << Student::getCount() << endl;
    Student ::setSchoolName("Information Technology Institute");
    cout << "School name after editing: " << Student::getSchoolName() << endl;
}

void fillStd(Student &std)
{
    int grades[5];
    char name[20];
    int id;
    cout << "Enter Student name:";

    cin >> name;
    std.setName(name);

    cout << "Enter Student id:";
    cin >> id;
    std.setId(id);

    for (int i = 0; i < 5; i++)
    {
        cout << "Enter Student grade for subject" << i + 1 << ":" << endl;
        cin >> grades[i];
    }

    std.setGrades(grades);
}

// float sumOfGrades(float grades[5])
// {
//     float sum = 0;
//     for (int i = 0; i < 5; i++)
//     {
//         sum += grades[i];
//     }
//     return sum;
// }

void printStd(Student std)
{
    cout << "The of student id: " << std.getId() << " with name: " << std.getName() << " is: " << endl;
    for (int i = 0; i < 5; i++)
    {
        cout << "Grade " << i + 1 << "is: " << std.getGrades()[i] << endl;
    }

    // return std;
}
