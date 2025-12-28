import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Graphics;
import java.util.Date;

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
    
    public MyPanel(){
        th = new Thread(this);
        th.start();
    }
    
    public void paint(Graphics g){
        
        Date date = new Date();
        g.drawString(date.toString(), 200, 200);
    }
    
    public void run(){
        
        while(true){
            try{
                repaint();
                Thread.sleep(1000);
            }catch(InterruptedException e){
                System.out.println("Error");
            }
        }
    }
}

