import java.util.StringTokenizer;

public class WordSubstring {

    public static void main(String[] args) {

        if (args.length != 1) {
            
            System.out.println("Please Enter The number in the form of XXX.XXX...");
        }else{
            
            String num = args[0];
            
            while (num.contains(".")) {
                
                int index = num.indexOf(".");
                System.out.println(num.substring(0, index));
                
                num = num.substring(index + 1);
            }
            
            System.out.println(num);
        }
    }
}
