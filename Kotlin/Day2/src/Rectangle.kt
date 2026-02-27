class Rectangle(var width: Double = 0.0, var height: Double = 0.0) : Shape(width) {

    override fun calcArea(): Double {
        return width * height
    }
}
