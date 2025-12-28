public class Calculator{
    
    public static void main(String[] args){
        if (args.length != 3) {
            
                    System.out.println("Please Enter Operand Operator Operand");
                }else{
                    
                    double num1 = Double.parseDouble(args[0]);
                    String operator = args[1];
                    double num2 = Double.parseDouble(args[2]);
                    double result = 0;
                    
                    switch(operator){
                            case "+":
                            result = num1 + num2;
                            break;
                            
                        case "-":
                            if(num1 > num2){
                                result = num1 - num2;
                            }else{
                                result = num2 - num1;
                            }
                        break;
                            
                        case "x":
                        result = num1 * num2;
                        break;
                            
                        case "/":
                            if(num2 != 0){
                                result = num1 / num2;
                            }else{
                                System.out.println("You can't divide by zero.");
                                return;
                            }
                        break;
                    }
                    
                    System.out.println("Result = " + result);
                }
    }
   
}
