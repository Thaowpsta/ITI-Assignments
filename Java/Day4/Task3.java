import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Graphics;
import java.awt.Color;

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

class MyPanel extends JPanel implements Runnable{
    
    Thread th;
    int x = 400, y = 250;
    int dx = 10, dy = 10;
    
    
    public MyPanel(){
        th = new Thread(this);
        th.start();
    }
    
    public void paint(Graphics g){
        
        g.setColor(Color.RED);
        g.fillOval(x, y, 50, 30);
    }
    
    public void run(){
        
        while(true){
            try{
                x += dx;
                y += dy;

                if(x <= 0 || (x + 50) >= 500){
                    dx = -dx;
                }
                
                if(y <= 0 || (y + 30) >= 500){
                    dy = -dy;
                }
  
                repaint();
                Thread.sleep(50);
            }catch(InterruptedException e){
                System.out.println("Error");
            }
        }
    }
}



