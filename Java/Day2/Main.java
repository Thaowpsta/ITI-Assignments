public class Main{
    
    public static void main(String[] args){
        
        Complex num1 = new Complex(5, 6);
                
        Complex sum = num1.add(3, 2);
        Complex diff = num1.subtract(3, 2);

        System.out.println("Addition Result: " + sum);
        System.out.println("Subtraction Result: " + diff);
    }
}
