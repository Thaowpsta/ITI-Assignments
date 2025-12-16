#include <iostream>
#include <termios.h>
#include <unistd.h>
#include <cctype>
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

    int flag = 1, selected = 0, size;
    char ch;
    cout << "Enter the size of the word: ";
    cin >> size;
    char* buffer = new char[size];
    char* ptr = buffer;

    clearScreen();

    for (int i = 0; i < size; i++)
    {
        buffer[i] = '\003';
    }
    
    buffer = ptr;

    if (buffer != NULL)
    {
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
                    if (ptr < (strlen(buffer) + buffer))
                        ptr++;
                    break;
                case 'D': // Left arrow
                    if (ptr > buffer)
                        ptr--;
                    break;
                default:
                    break;
                }
            }else if (next == '\033') {
                flag = 0;
            }
        }
        else if (ch == '\n')
        {
            cout << "\nThe word is: " << buffer << endl;
            flag = 0;
        }
        else if (isprint(ch))
        {
            if (ptr < ((size - 1) + buffer))
            {
                *ptr = ch;
                ptr++;
                selected++;
            }
        }

        if (flag && (selected < (size)))
        {
            moveCursor(1, 1);
            clearLine();

            for (int i = 0; i < size; i++)
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

            moveCursor(1,(ptr - buffer + 1));
        }

    } while (flag);

        delete buffer;
    }
    else
    {
        cout << "Memory allocation failed." << endl;
    }
    
    cout << "\nProgram ended." << endl;

    return 0;

}