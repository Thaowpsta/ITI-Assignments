import 'task1.dart';
import 'task2.dart';

void main() {
  
  print('=== Task 1 ===');
  Dog dog = Dog('Rex');
  dog.walk();
  dog.swim();

  Parrot parrot = Parrot('Rio');
  parrot.fly();
  parrot.talk();

  Cat cat = Cat('Luna');
  cat.walk();

  print('=== Task 2 ===');

  String sampleText = "all letters are small";
  print('Original: $sampleText');
  print('Title Case: ${sampleText.toTitleCase()}');

  String email1 = "test@example.com";
  String email2 = "invalid email";
  print('$email1 ${email1.isValidEmail()}');
  print('$email2 ${email2.isValidEmail()}');

  String wordToReverse = "Thaowpsta";
  print('Reverse of "$wordToReverse" is "${wordToReverse.reverse()}"');
}
