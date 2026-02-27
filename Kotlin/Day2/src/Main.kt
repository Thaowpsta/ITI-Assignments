fun main() {

    val rectangle = Rectangle(5.0, 4.0)
    val circle = Circle(3.0)
    val triangle = Triangle(6.0, 2.0)

    val picture = Picture()

    val totalArea = picture.sumAreas(rectangle, circle, triangle)

    println("Total Area = $totalArea")
}
