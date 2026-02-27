class Complex(
    val real: Double,
    val imag: Double = 0.0
) {

    constructor(real: Double) : this(real, 0.0)

    operator fun plus(other: Complex): Complex {
        return Complex(
            real = this.real + other.real,
            imag = this.imag + other.imag
        )
    }

    operator fun minus(other: Complex): Complex {
        return Complex(
            real = this.real - other.real,
            imag = this.imag - other.imag
        )
    }
}

fun Complex.myPrint() {
    val sign = if (imag >= 0) "+" else "-"
    println("$real $sign ${kotlin.math.abs(imag)}i")
}

fun main() {

    val c1 = Complex(3.0, 4.0)
    val c2 = Complex(real = 1.0)

    val sum = c1 + c2
    val diff = c1 - c2

    sum.myPrint()
    diff.myPrint()
}

