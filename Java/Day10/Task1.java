interface Sayable{
    void say();
}

class MethodReference {
    public static void saySomething(){
        System.out.println("Hello, this is static method.");
    }
    public static void main(String[] args) {

        // made say has the imp of saySomething()
        Sayable sayable = MethodReference::saySomething;
        sayable.say();
    }
}
