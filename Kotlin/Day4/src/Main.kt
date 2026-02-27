fun main() {
    var isRunning = true

    val librarian = Librarian("Sarah", "LIB001")
    val db = LibraryDataBase(librarian)

    db.addBook(Book("Kotlin Programming", "1", "Thaowpsta", 300))
    db.addBook(Magazine("Tech Monthly", "3", "Nadine", 50))

    val user1 = User("Ahmed", "U001", "Student")
    db.addUser(user1)
    db.lendBook(db.searchForABook("Kotlin Programming")!!, user1)

    while (isRunning) {
        println("\n--- Library System Menu ---")
        println("1. View Available Books")
        println("2. Search for a Book")
        println("3. Add a New Book")
        println("4. Add a New User")
        println("5. Show Borrowed Books")
        println("6. Exit")
        print("Choose an option: ")

        val choice = try {
            readln().toInt()
        } catch (e: NumberFormatException) {
            -1
        }

        when (choice) {
            1 -> db.viewAvailableBooks()

            2 -> {
                print("Enter search query: ")
                db.searchForABook(readln())
            }

            3 -> {
                println("\n--- Add Book ---")
                print("Title: ")
                val t = readln()
                print("ISBN: ")
                val i = readln()
                if (t.isNotEmpty()) {
                    db.addBook(Book(t, i, "Unknown", 0))
                }
            }

            4 -> {
                println("\n--- Add New User ---")
                print("Enter Name: ")
                val name = readln()

                print("Enter ID: ")
                val id = readln()

                print("Enter Job (e.g., Student, Teacher): ")
                val job = readln()

                if (name.isNotEmpty() && id.isNotEmpty()) {
                    val newUser = User(name, id, job)
                    db.addUser(newUser)
                } else {
                    println("Error: Name and ID cannot be empty.")
                }
            }

            5 -> db.viewBorrowedBooks()

            6 -> {
                println("Exiting...")
                isRunning = false
            }

            else -> println("Invalid option.")
        }
    }
}