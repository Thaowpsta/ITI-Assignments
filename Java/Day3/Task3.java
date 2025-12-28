import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Graphics;
import java.awt.Color;

class LampFrame{
    
    public static void main(String[] args){
        
        JFrame frame = new JFrame("Lamp");
        frame.setSize(500, 500);
        frame.setVisible(true);
        
        LampPanel panel = new LampPanel();

        frame.setContentPane(panel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
}

class LampPanel extends JPanel{
    
    public void paint(Graphics g){
        
        //x = 200, width = 100 -> centerX = 250
        
        
        g.setColor(Color.YELLOW);
        g.fillOval(200, 100, 100, 30);
        g.setColor(Color.BLACK);
        g.drawOval(200, 100, 100, 30);

        g.drawLine(200, 115, 180, 200);
        g.drawLine(300, 115, 315, 200);
        
        g.drawArc(180, 185, 135, 30, 0, -180);
        
        g.setColor(Color.YELLOW);
        g.fillOval(205, 155, 15, 20);
        g.fillOval(230, 150, 30, 40);
        g.fillOval(270, 155, 15, 20);

        g.setColor(Color.BLACK);
        g.drawOval(205, 155, 15, 20);
        g.drawOval(230, 150, 30, 40);
        g.drawOval(270, 155, 15, 20);
        
        g.drawLine(240, 215, 220, 280);
        g.drawLine(250, 215, 270, 280);
        
        g.drawRect(180, 280, 130, 15);

        
    }
}
