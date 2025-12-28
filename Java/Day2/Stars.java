public class Stars{
    
    public static void main(String[] args){
        
        System.out.println("=== Using 2 Loops ===");
        
        for(int i = 0; i < 5; i++){
            
            for(int j = 0; j < i; j++){
                System.out.print("*");
            }
            
            System.out.print("\t");
            
            for (int m = 0; m < 5 - i; m++) {
                    System.out.print(" ");
                }
            
            for (int k = 1; k <= i; k++) {
                System.out.print("* ");
            }
            
            System.out.println();
        }
        
        System.out.println();
        System.out.println();

        System.out.println("=== Using 1 Loops ===");
        
        String rightTriangle = "";
        String triangle = "";

        for (int i = 1; i < 5; i++) {

            rightTriangle += "*";
            triangle += "* ";
            
            System.out.println(rightTriangle + "\t" + triangle);
        }
    }
}
