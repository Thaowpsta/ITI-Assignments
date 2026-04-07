abstract class Pet {
  String name;
  Pet(this.name);
}

mixin Walkable on Pet {
  void walk() => print('$name is walking.');
}

mixin Swimmable on Pet {
  void swim() => print('$name is swimming.');
}

mixin Flyable on Pet {
  void fly() => print('$name is flying.');
}

mixin Talkable on Pet {
  void talk() => print('$name is talking.');
}

class Dog extends Pet with Walkable, Swimmable {
  Dog(super.name);
}

class Cat extends Pet with Walkable {
  Cat(super.name);
}

class Parrot extends Pet with Flyable, Talkable {
  Parrot(super.name);
}