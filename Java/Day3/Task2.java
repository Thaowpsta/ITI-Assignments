import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.GraphicsEnvironment;
import java.awt.Graphics;
import java.awt.Font;
//import java.awt.Dimension;
//import javax.swing.JScrollPane;


class MyFrame2{
    public static void main(String[] args){
        
        JFrame frame = new JFrame();
        
        frame.setTitle("First Frame");
        frame.setSize(500, 500);
        frame.setVisible(true);
        
        MyPanel2 panel = new MyPanel2();
        
//        JScrollPane scrollPane = new JScrollPane(panel);
        
        frame.setContentPane(panel);
        
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
}

class MyPanel2 extends JPanel{
    
    String[] fonts = GraphicsEnvironment.getLocalGraphicsEnvironment().getAvailableFontFamilyNames();
    
//    MyPanel2() {
//            setPreferredSize(new Dimension(450, fonts.length * 25));
//        }

    public void paint(Graphics g){
        for(int i = 0; i < fonts.length; i++){
            
            Font font = new Font(fonts[i], Font.BOLD, 15);
            g.setFont(font);
            g.drawString(fonts[i], 200, (2 + (2 * i)) * 20);
        }
    }
}

