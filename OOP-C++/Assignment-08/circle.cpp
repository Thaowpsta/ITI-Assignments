#include <cmath>
#include <iostream>

using namespace std;

class Point
{
    int x, y;

public:
    Point()
    {
        x = y = 0;
    };

    Point(int m)
    {
        x = y = m;
    };

    Point(int m, int n)
    {
        x = m;
        y = n;
    };

    void setX(int m)
    {
        x = m;
    };

    void setY(int m)
    {
        y = m;
    };

    int getX()
    {
        return x;
    };

    int getY()
    {
        return y;
    };
};

class Circle_A
{
    Point *p1, *p2;
    double radious, area, circumfrance;

public:
    Circle_A()
    {
        p1 = p2 = NULL;
        radious = area = circumfrance = 0;
    };

    Circle_A(Point *pa, Point *pb)
    {
        p1 = pa;
        p2 = pb;
        if (p1 != NULL && p2 != NULL)
        {
            radious = sqrt(pow(abs(p2->getX() - p1->getX()), 2) + pow(abs(p2->getY() - p1->getY()), 2));
            area = M_PI * radious * radious;
            circumfrance = 2 * M_PI * radious;
        }
        else
        {
            radious = area = circumfrance = 0;
        }
    };

    void setP1(Point *p)
    {
        p1 = p;

        if (p1 != NULL && p2 != NULL)
        {
            radious = sqrt(pow(abs(p2->getX() - p1->getX()), 2) + pow(abs(p2->getY() - p1->getY()), 2));
            area = M_PI * radious * radious;
            circumfrance = 2 * M_PI * radious;
        }
        else
        {
            radious = area = circumfrance = 0;
        }
    }

    void setP2(Point *p)
    {
        p2 = p;

        if (p1 != NULL && p2 != NULL)
        {
            radious = sqrt(pow(abs(p2->getX() - p1->getX()), 2) + pow(abs(p2->getY() - p1->getY()), 2));
            area = M_PI * radious * radious;
            circumfrance = 2 * M_PI * radious;
        }
        else
        {
            radious = area = circumfrance = 0;
        }
    }

    double getArea()
    {
        return area;
    }

    double getCircum()
    {
        return circumfrance;
    }
};

class Circle_c
{
    Point p1, p2;
    double radious, area, circumfrance;

public:
    Circle_c()
    {
        p1.setX(0);
        p1.setY(0);
        p2.setX(0);
        p2.setY(0);

        radious = area = circumfrance = 0;
    };

    Circle_c(int x1, int y1, int x2, int y2) : p1(x1, y1), p2(x2, y2)
    {
        radious = sqrt(pow(abs(x2 - x1), 2) + pow(abs(y2 - y1), 2));
        area = M_PI * radious * radious;
        circumfrance = 2 * M_PI * radious;
    };

    void setP1(int m, int n)
    {
        p1.setX(m);
        p1.setY(n);
    }

    void setP2(int m, int n)
    {
        p2.setX(m);
        p2.setY(n);
    }

    double getArea()
    {
        return area;
    }

    double getCircum()
    {
        return circumfrance;
    }
};

int main()
{
    Circle_A circle1;
    Point p1(3, 4);
    Point p2(10, 20);

    cout << "The circle area from default and A class is: " << circle1.getArea() << " and circum: " << circle1.getCircum() << endl;

    circle1.setP1(&p1);
    circle1.setP2(&p2);
// Circle C4 (&p1,&p2);
    cout << "The circle area after using setters and A class is: " << circle1.getArea() << " and circum: " << circle1.getCircum() << endl;


    Circle_c circle2;

    cout << "The circle area from default and C class is: " << circle2.getArea() << " and circum: " << circle2.getCircum() << endl;

    Circle_c circle3(2,3,4,5);
        cout << "The circle area from parameterized and C class is: " << circle3.getArea() << " and circum: " << circle3.getCircum() << endl;

}