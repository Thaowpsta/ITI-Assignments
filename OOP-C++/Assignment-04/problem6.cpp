#include <iostream>
#include <termios.h>
#include <unistd.h>
#include <cctype>
#define SIZE 50
using namespace std;

void clearScreen()
{
    cout << "\033[2J\033[1;1H";
}

void moveCursor(int row, int col)
{
    cout << "\033[" << row << ";" << col << "H";
    cout.flush();
}

void clearLine()
{
    cout << "\033[2K";
}

char readKey()
{
    struct termios oldt, newt;
    char ch;
    tcgetattr(STDIN_FILENO, &oldt);
    newt = oldt;
    newt.c_lflag &= ~(ICANON | ECHO);
    tcsetattr(STDIN_FILENO, TCSANOW, &newt);
    read(STDIN_FILENO, &ch, 1);
    tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
    return ch;
}

int main()
{
    int flag = 1, selected = 0;
    char ch;
    char buffer[SIZE] = {0};

    clearScreen();
    // moveCursor(1, 1);

    do
    {
        ch = readKey();

        if (ch == '\033')
        {
            char next = readKey();
            if (next == '[')
            {
                char arrow = readKey();
                switch (arrow)
                {
                case 'C': // Right arrow
                    if (selected < SIZE - 1)
                        selected++;
                    break;
                case 'D': // Left arrow
                    if (selected > 0)
                        selected--;
                    break;
                case '\033':
                    flag = 0;
                    break;

                default:
                    break;
                }
            }
        }
        else if (ch == '\n')
        {
            cout << "\nThe word is: " << buffer << endl;
            flag = 0;
        }
        else if (isprint(ch))
        {
            if (selected < SIZE - 1)
            {
                buffer[selected] = ch;
                selected++;
            }
        }

        if (flag)
        {
            moveCursor(1, 1);
            clearLine();

            for (int i = 0; i < SIZE; i++)
            {
                if (buffer[i] == 0)
                {
                    cout << " ";
                }
                else
                {
                    cout << buffer[i];
                }
            }

            moveCursor(1, selected + 1);
        }

    } while (flag);

    cout << "Program ended." << endl;

    return 0;
}