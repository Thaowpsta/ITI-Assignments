class Triangle(var base: Double = 0.0, var height: Double = 0.0) : Shape(base) {

    override fun calcArea(): Double {
        return 0.5 * base * height
    }
}
