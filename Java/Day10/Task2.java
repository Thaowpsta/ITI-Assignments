interface Sayable{
    void say();
}

 class MethodReference {
    
    public void saySomething(){
        System.out.println("Hello, this is non-static method.");
    }
    
    public static void main(String[] args) {
        MethodReference methodReference = new MethodReference();
        
        Sayable sayable = methodReference::saySomething;
        sayable.say();
            
        Sayable sayable2 = new MethodReference()::saySomething;
        
        sayable2.say();
    }
}
