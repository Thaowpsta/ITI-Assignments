fun main() {
    val ref: Number = ByThrees()

    println("Generating numbers To increment by three:")
    for (i in 1..4) {
        println("Next value: ${ref.getNext()}")
    }

    println("==========================================")
    ref.reset()
    println("Value after reset: $ref")
    println("Value after Increment: ${ref.getNext()}")

    println("==========================================")
    println("Resetting start to 150")
    ref.setStart(150)
    println("Next value: ${ref.getNext()}")
}