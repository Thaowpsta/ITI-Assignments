abstract class LibraryItem(
    val title: String,
    val isbn: String,
    val publication: String,
    val numberOfPages: Int
) {
    var isAvailable: Boolean = true

    fun isAvaliable(): Boolean {
        return isAvailable
    }

    override fun toString(): String {
        return "$title (ISBN: $isbn)"
    }
}

class Book(title: String, isbn: String, pub: String, pages: Int) : LibraryItem(title, isbn, pub, pages)
class Journal(title: String, isbn: String, pub: String, pages: Int) : LibraryItem(title, isbn, pub, pages)
class Magazine(title: String, isbn: String, pub: String, pages: Int) : LibraryItem(title, isbn, pub, pages)
