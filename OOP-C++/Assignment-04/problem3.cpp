#include <iostream>
using namespace std;

int main()
{
    int std_grades[3][4]{
        {85, 90, 78, 92},
        {88, 76, 95, 89},
        {91, 82, 87, 94}};

    int highest_score = 0;
    int top_student = 0;

    for (int i = 0; i < 3; ++i)
    {
        int sum = 0;
        for (int j = 0; j < 4; ++j)
        {
            sum += std_grades[i][j];
        }
        if (sum > highest_score)
        {
            highest_score = sum;
            top_student = i;
        }
        cout << "Total score of student " << (i + 1) << ": " << sum << endl;
        }
    cout << "Student " << (top_student + 1) << " is Ranked first in the class with score: " << highest_score << "." << endl;

    for (int j = 0; j < 4; j++)
    {
        int sum_subject = 0;
        for (int i = 0; i < 3; i++){
            sum_subject += std_grades[i][j];
        }
        cout << "Average score of subject " << (j + 1) << ": " << sum_subject / 3 << endl;
    }
    
}