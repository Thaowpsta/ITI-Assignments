class LibraryDataBase(val currentLibrarian: Librarian) {

    private val availableBooks: MutableList<LibraryItem> = mutableListOf()
    private val borrowedBooks: MutableMap<LibraryItem, User> = mutableMapOf()
    private val users: MutableList<User> = mutableListOf()

    fun addBook(item: LibraryItem) {
        availableBooks.add(item)
        println("Added to library: ${item.title}")
    }

    fun addUser(user: User) {
        users.add(user)
        println("User registered: ${user.name} (${user.job})")
    }

    fun viewAvailableBooks() {
        println("\n--- Available Items ---")
        if (availableBooks.isEmpty()) {
            println("No items currently available.")
        } else {
            availableBooks.forEach { item ->
                println("- ${item.title} [Type: ${item::class.simpleName}]")
            }
        }
    }

    fun searchForABook(query: String): LibraryItem? {
        val found = availableBooks.find { it.title.contains(query, ignoreCase = true) || it.isbn == query }

        if (found != null) {
            println("Found: ${found.title}")
        } else {
            println("Item not found matching: $query")
        }
        return found
    }

    fun viewBorrowedBooks() {
        println("\n--- Borrowed Items List ---")
        if (borrowedBooks.isEmpty()) {
            println("No items are currently borrowed.")
        } else {
            borrowedBooks.forEach { (item, user) ->
                println("Book: \"${item.title}\" is borrowed by ${user.name}")
            }
        }
    }

    fun lendBook(item: LibraryItem, user: User) {
        if (availableBooks.contains(item)) {
            availableBooks.remove(item)
            borrowedBooks[item] = user
            item.isAvailable = false
            println("System Update: ${item.title} lent to ${user.name}")
        }
    }
}