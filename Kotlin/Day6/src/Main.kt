import kotlinx.coroutines.*
import java.util.concurrent.CancellationException
import kotlin.time.Duration.Companion.seconds

fun main() = runBlocking {

    println("============ Task 1 ============")
    val job1 = launch {
        for (i in 1..10) {

            val res = async {
                delay(100)
                return@async i
            }
            println("${res.await()} ")
        }
    }
    job1.join()

    println("============ Task 2 ============")
    val res = async {
        getFactorial(5)
    }
    println("Factorial of 5 is: ${res.await()}")

    println("============ Task 3 ============")
    try {
        withTimeout(10000) {

            launch {
                repeat(100) { i ->
                    println("Task A: $i")
                    delay(1000)
                }
            }
            launch {
                repeat(100) { i ->
                    println("Task B: $i")
                    delay(1000)
                }
            }
            delay(12000)
        }
    } catch (e: TimeoutCancellationException) {
        println("Tasks cancelled after 10 seconds.")
    }

    println("============ Task 4 ============")
    val numbers = intArrayOf(1, 2, 3, 4, 5)
    sumArray(numbers)

    println("============ Task 5 ============")
    val jobToCancel = launch {
        try {
            repeat(1000) { i ->
                println("Working... $i")
                delay(100)
            }
        } catch (e: CancellationException) {
            println("Job was cancelled!")
        }
    }
    delay(1000)

    println("Cancelling...")
    jobToCancel.cancelAndJoin()
    println("Done.")
}


suspend fun getFactorial(n: Int): Long {
    var result: Long = 1
    repeat(n) { i ->
        delay(50)
        result *= (i + 1)
    }
    return result
}

suspend fun sumArray(arr: IntArray) {
    var sum = 0
    delay(1.seconds)
    for (num in arr) {
        sum += num
    }
    println("Sum of array: $sum")
}