public class WordSplit {

    public static void main(String[] args) {

        if (args.length != 1) {
            
            System.out.println("Please Enter The number in the form of XXX.XXX...");
        }else{
            
            String num = args[0];
            String[] splitted = num.split("\\.");

            for (String elem : splitted) {
                System.out.println(elem);
            }
        }
        }
}
