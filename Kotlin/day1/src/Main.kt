package com.example.lib

import java.util.Random

fun main() {

    //Task 1
    println("===================== Task 1 =====================")
    print("Enter your name: ")

    val input = readLine()

    if (input.isNullOrBlank()) println("Hello, You haven't entered your name") else println("Hello, $input")

    //Task 2
    println("===================== Task 2 =====================")
    val random = Random()
    val array = IntArray(100){
         random.nextInt(1, 100)
    }


    println("Numbers less than or equal to 10:")

    for (num in array) {
        if (num <= 10) {
            println(num)
        }
    }

    //Task 3
    println("===================== Task 3 =====================")
    print("Enter the first number: ")
    val num1 = readLine()?.toDoubleOrNull()

    print("Enter the second number: ")
    val num2 = readLine()?.toDoubleOrNull()

    print("Enter operation (+, -, *, /): ")
    val operation = readLine()

//MaxOF, MinOF
    if (num1 != null && num2 != null) {
        val result = when (operation) {
            "+" -> calculate(num1, num2, { a: Double, b: Double -> a + b })
            "-" -> if (num1 > num2) calculate(num1, num2, { a: Double, b: Double -> a - b }) else calculate(num1, num2, { a: Double, b: Double -> b - a })
            "*" -> calculate(num1, num2, { a: Double, b: Double -> a * b })
            "/" -> {
                if (num2 != 0.0) calculate(num1, num2, { a: Double, b: Double -> a / b })
                else {
                    println("Cannot divide by zero!")
                }
            }

            else -> {
                println("Invalid operation!")
            }
        }
        println("Result: $result")
    }else{
        println("You haven't entered a number or operation!")
    }

    //Task 4
    println("===================== Task 4 =====================")
    for (i in 1..6){
        repeat(i){
            print("* ")
        }
        println()
    }

    println("----------------------")

    for (i in 1..6){
        repeat(6 - i){
            print(" ")
        }
        repeat(i){
            print("* ")
        }
        println()
    }

    //Task 5
    println("===================== Task 5 =====================")
    print("Enter your first name: ")
    val firstName = readLine()

    print("Enter your last name: ")
    val lastName = readLine()

    if (firstName.isNullOrBlank() || lastName.isNullOrBlank()) {
        println("First name and last name are required!")
    } else {
        println("Your full Name: $firstName $lastName")
    }
}

fun calculate(num1: Double, num2: Double, operation: (Double, Double) -> Double): Double{
    return operation(num1, num2)
}