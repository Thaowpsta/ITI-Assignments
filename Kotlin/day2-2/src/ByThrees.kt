class ByThrees : Number {
    var value: Int = 0
    var st: Int = 0

    override fun getNext(): Int {
        value += 3
        return value
    }

    override fun reset() {
        value = st
    }

    override fun setStart(x: Int) {
        st = x
        value = st
    }

    override fun toString(): String {
        return "$value"
    }
}