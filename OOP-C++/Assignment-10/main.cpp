#include <iostream>

using namespace std;

class Shape
{
protected:
    int dim1, dim2;

public:
    Shape()
    {
        dim1 = dim2 = 0;
    }
    Shape(int dim)
    {
        dim1 = dim2 = dim;
    }
    Shape(int d1, int d2)
    {
        dim1 = d1;
        dim2 = d2;
    }
    void setDim1(int d1)
    {
        dim1 = d1;
    }
    void setDim2(int d2)
    {
        dim2 = d2;
    }
    int getDim1()
    {
        return dim1;
    }
    int getDim2()
    {
        return dim2;
    }
    virtual float area() = 0;
};

class Cirlce : public Shape
{
public:
    Cirlce() {}
    Cirlce(int r) : Shape(r) {}

    float area()
    {
        return 3.14 * dim1 * dim2;
    }
};

class Rectangle : public Shape
{
public:
    Rectangle() {}
    Rectangle(int l, int w) : Shape(l, w) {}

    float area()
    {
        return dim1 * dim2;
    }
};

class Square : public Rectangle
{
public:
    Square() {}
    Square(int l) : Rectangle(l, l) {}

    float area()
    {
        return dim1 * dim2;
    }
};

class Triangle : public Shape
{
public:
    Triangle() {}
    Triangle(int b, int h) : Shape(b, h) {}

    float area()
    {
        return 0.5 * dim1 * dim2;
    }
};

// class GeoShape{
//     Shape *ptr[4];

//     public:
//     GeoShape(Shape *p1, Shape *p2, Shape *p3, Shape *p4){
//         ptr[0] = p1;
//         ptr[1] = p2;
//         ptr[2] = p3;
//         ptr[3] = p4;
//     }

//     float totalAreas(){
//         float sum{0};

//         for (int i = 0; i < 4; i++)
//         {
//             sum += ptr[i]->area();
//         }
//         return sum;
//     }
// };

class GeoShape
{
    Shape **shapes;
    int count;

public:
    GeoShape(Shape **shape, int n)
    {
        shapes = shape;
        count = n;
    }

    float totalAreas()
    {
        float sum{0};

        for (int i = 0; i < count; i++)
        {
            sum += shapes[i]->area();
        }
        return sum;
    }
};

int main()
{

    int n;
    cout << "Enter the number of n(max is 5): " << endl;

    cin >> n;

    Shape **shapes = new Shape *[n];

    if (shapes != NULL)
    {
        Cirlce circle(7);
        Rectangle rectangle(5, 20);
        Triangle triangle(20, 10);
        Square square(6);

        shapes[0] = &circle;
        shapes[1] = &rectangle;
        shapes[2] = &triangle;
        shapes[3] = &square;
        shapes[4] = &square;

        GeoShape geoshape(shapes, n);

        cout << "Total Areas: " << geoshape.totalAreas() << endl;

        delete []shapes;
    }else{
        cout << "can't allocate pointer";
    }
}