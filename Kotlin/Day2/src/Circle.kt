class Circle(radius: Double = 0.0) : Shape(radius) {

    override fun calcArea(): Double {
        return Math.PI * dim * dim
    }
}
