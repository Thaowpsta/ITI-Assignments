import 'dart:math';

void main() {

  //======== Task 1 ========
  print("======== Task 1 ========");
  checkNumber(5);
  checkNumber(-3);
  checkNumber(0);

  //======== Task 2 ========
  print("======== Task 2 ========");
  nullSafetyDemo();

  //======== Task 3 ========
  print("======== Task 3 ========");
  print("Factorial of 5 is: ${factorial(3)}");

  //======== Task 4 ========
  print("======== Task 4 ========");
  print("AS String");
  String var1 = "10";
  String var2 = "20";
  print("Before Swap: var1 = $var1, var2 = $var2");

  var swapped1 = swap<String>(var1, var2);
  var1 = swapped1.$1;
  var2 = swapped1.$2;
  print("After Swap: var1 = $var1, var2 = $var2");

  print("================");
  print("AS Integer");
  int var3 = 10;
  int var4 = 20;
  print("Before Swap: var1 = $var3, var2 = $var4");

  var swapped2 = swap<int>(var3, var4);
  var3 = swapped2.$1;
  var4 = swapped2.$2;
  print("After Swap: var1 = $var3, var2 = $var4");

  //======== Task 5 ========
  print("======== Task 5 ========");
  printUserDetails(name: "Thaowpsta", age: 24);
  printUserDetails(name: "Nardeen", age: 27, country: "Canada");

  //======== Task 6 ========
  print("======== Task 6 ========");
  var addFunc = calculation('+');
  var powerFunc = calculation('^');
  print("Addition (10 + 5) = ${addFunc(10, 5)}");
  print("Power (2 power 3) = ${powerFunc(2, 3)}");

  //======== Task 7 ========
  print("======== Task 7 ========");
  String evenOrOdd(n) => n % 2 == 0 ? "Even" : "Odd";
  showEvenAndOddNum(7, evenOrOdd);
  showEvenAndOddNum(12, evenOrOdd);
}

void checkNumber(num number) {
  String result = number > 0 ? "Positive" : (number < 0 ? "Negative" : "Zero");
  print("The number $number is $result.");
}

void nullSafetyDemo() {
  String? myText = "Task 2";
  print(myText);

  myText = null;
  print(myText ?? "The default value");
}

int factorial(int n){
  if(n <= 1) return 1;
  return n * factorial(n - 1);
}

(T, T) swap<T> (T arg1, T arg2){
  return (arg2, arg1);
}

void printUserDetails({required String name, required int age, String country = "Egypt"}) {
  print("Name: $name, Age: $age, Country: $country");
}

// void printUserDetails(String name, int age, [String country = "Egypt"]) {
//   print("Name: $name, Age: $age, Country: $country");
// }

num Function(num, num) calculation(String operation) {
  switch (operation) {
    case '+': return (num num1, num num2) => num1 + num2;
    case '-': return (num num1, num num2) => num1 - num2;
    case '*': return (num num1, num num2) => num1 * num2;
    case '/': return (num num1, num num2) => num1 / num2;
    case '%': return (num num1, num num2) => num1 % num2;
    case '^': return (num num1, num num2) => pow(num1, num2);
    default: throw ArgumentError("Invalid operator: $operation");
  }
}

void showEvenAndOddNum(int num, String Function(int) checkEvenOdd) {
  String result = checkEvenOdd(num);
  print("$num is $result");
}