import javax.swing.JFrame;

public class MyFrame{
    public static void main(String[] args){
        
        JFrame frame = new JFrame();
        
        frame.setTitle("First Frame");
        frame.setSize(200, 200);
        frame.setVisible(true);
        
        MyPanal panel = new MyPanal();
        
        frame.setContentPane(panel);
        
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
}
