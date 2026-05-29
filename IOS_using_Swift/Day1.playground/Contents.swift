import UIKit

//======== Task 1 ========
func getFactorial(number: Int) -> Int {
    if number <= 0 {
        return 1
    }
    
    var result = 1
    for i in 1...number {
        result *= i
    }
    
    return result
}

let factResult = getFactorial(number: 5)
print("Factorial of 5 is \(factResult)")

//======== Task 2 ========
func calcPowerLoop(base: Int, power: Int) -> Int {
    var result = 1
    for _ in 0..<power {
        result *= base
    }
    return result
}

func calcPowerRecursion(base: Int, power: Int) -> Int {
    if power == 0 {
        return 1
    }
    return base * calcPowerRecursion(base: base, power: power - 1)
}

print("Loop: 2 to the power of 3 is \(calcPowerLoop(base: 2, power: 3))")
print("Recursion: 2 to the power of 3 is \(calcPowerRecursion(base: 2, power: 3))")

//======== Task 3 ========
func sortArray(array: [Int]) -> [Int] {
    var sortedArray = array
    
    if sortedArray.count > 1 {
        for _ in 0..<sortedArray.count {
            for j in 0..<(sortedArray.count - 1) {
                if sortedArray[j] > sortedArray[j + 1] {
                    let temp = sortedArray[j]
                    sortedArray[j] = sortedArray[j + 1]
                    sortedArray[j + 1] = temp
                }
            }
        }
    }
    
    return sortedArray
}

let unsortedNumbers = [5, 2, 9, 1, 5, 6]
let sortedNumbers = sortArray(array: unsortedNumbers)
print("Sorted Array: \(sortedNumbers)")

//======== Task 4 ========
func calMinAndMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    
    var currentMin = array[0]
    var currentMax = array[0]
    
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    
    return (currentMin, currentMax)
}

let numbers = [8, 3, 19, 4, 1, 7]
if let bounds = calMinAndMax(array: numbers) {
    print("The min = \(bounds.min) and the max = \(bounds.max)")
} else {
    print("The array was empty.")
}

//======== Task 5 ========
func swap(a1: inout Int, b1: inout Int) {
    let temp = a1
    a1 = b1
    b1 = temp
}

var num1 = 5
var num2 = 6

print("Before swap: num1 = \(num1), num2 = \(num2)")

swap(a1: &num1, b1: &num2)

print("After swap: num1 = \(num1), num2 = \(num2)")
