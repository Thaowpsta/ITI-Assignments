#include <iostream>
#define SIZE 50
using namespace std;

int main()
{
    int floor[SIZE][SIZE] = {0};
    int penDown = 0, direction = 0, row = 0, col = 0, command, steps, flag = 1;

    cout << "Commands Guide:" << endl
         << "1: Pen up" << endl
         << "2: Pen down" << endl
         << "3: Turn right" << endl
         << "4: Turn left" << endl
         << "5: Move forward n spaces" << endl
         << "6: Print drawing" << endl
         << "9: End program" << endl
         << endl;

    while (flag)
    {
        cout << "Enter command: ";
        cin >> command;

        switch (command)
        {
        case 1:
            penDown = 0;
            break;

        case 2:
            penDown = 1;
            break;

        case 3:
            direction = (direction + 1) % 4; 
            break;

        case 4:
            direction = (direction + 3) % 4; 
            break;

        case 5:
            cout << "Enter number of steps: ";
            cin >> steps;

            for (int s = 0; s < steps - 1; s++)
            {
                switch (direction)
                {
                case 0: if (col + 1 < SIZE) col++; break;
                case 1: if (row + 1 < SIZE) row++; break; 
                case 2: if (col - 1 >= 0) col--; break;   
                case 3: if (row - 1 >= 0) row--; break;   
                }

                if (penDown)
                    floor[row][col] = 1;
            }
            break;

        case 6:
            for (int r = 0; r < SIZE; r++)
            {
                for (int c = 0; c < SIZE; c++)
                    cout << (floor[r][c] ? '*' : ' ');
                cout << endl;
            }
            break;

        case 9:
            flag = 0;
            cout << "Program ended." << endl;
            break;

        default:
            cout << "Invalid command! Try again." << endl;
        }
    }

    return 0;
}
