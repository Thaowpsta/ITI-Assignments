import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Toolkit;
import java.awt.Graphics;
import java.awt.Font;

class MyFrame{
    public static void main(String[] args){
        
        JFrame frame = new JFrame();
        
        frame.setTitle("First Frame");
        frame.setSize(500, 500);
        frame.setVisible(true);
        
        MyPanel panel = new MyPanel();
        
        frame.setContentPane(panel);
        
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
}

class MyPanel extends JPanel{
    
    Toolkit t = Toolkit.getDefaultToolkit();
    String[] fonts = t.getFontList();
    
    public void paint(Graphics g){
        for(int i = 0; i < fonts.length; i++){
            
            Font font = new Font(fonts[i], Font.BOLD, 15);
            g.setFont(font);
            g.drawString(fonts[i], 200, (2 + (2 * i)) * 20);
        }
    }
}
