fun main(){

    val user = Person("Thaowpsta", 100, "Female").apply {
        println("Inside apply: Name is: $name")
        name = "Thaowpsta Saiid"
    }

    val nameLength = user.let { p ->
        println("Inside let: ID is: ${p.id}")
        p.name.length
    }
    println("Name length calculated from 'let': $nameLength")

    val userInfo = user.run {
        "Inside run: User $name is $gender"
    }
    println(userInfo)
}

data class Person(var name: String, var id: Int, var gender: String)