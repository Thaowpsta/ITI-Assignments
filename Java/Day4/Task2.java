import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Graphics;

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
    int x = 0, y = 250;
    
    public MyPanel(){
        th = new Thread(this);
        th.start();
    }
    
    public void paint(Graphics g){
        
        g.drawString("Java World", x, y);
    }
    
    public void run(){
        
        while(true){
            try{
                x += 1;
                
                if(x > 500){
                    x = 0;
                }
                repaint();
                Thread.sleep(50);
            }catch(InterruptedException e){
                System.out.println("Error");
            }
        }
    }
}


