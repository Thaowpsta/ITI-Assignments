open class Person(val name: String, val id: String)

class Librarian(name: String, id: String) : Person(name, id)

class User(name: String, id: String, val job: String) : Person(name, id)

