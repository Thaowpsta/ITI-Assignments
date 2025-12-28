import java.util.StringTokenizer;

public class WordTokenizer {

    public static void main(String[] args) {

        if (args.length != 1) {
            
            System.out.println("Please Enter The number in the form of XXX.XXX...");
        }else{
            
            String num = args[0];
            StringTokenizer st = new StringTokenizer(num, ".");

            while (st.hasMoreTokens()) {
                System.out.println(st.nextToken());
            }
        }
    }
}

