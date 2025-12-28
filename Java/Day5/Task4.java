import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Graphics;
import java.awt.Color;
import javax.swing.JButton;
import java.awt.event.MouseEvent;
import java.awt.event.MouseAdapter;

class MyFrame{
    public static void main(String[] args){
        
        JFrame frame = new JFrame();
        
        frame.setTitle("First Frame");
        frame.setSize(500, 500);
        
        MyPanel panel = new MyPanel();
        
        frame.setContentPane(panel);
        frame.setVisible(true);

        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
}

class MyPanel extends JPanel implements Runnable{
    
    Thread th;
   
    int x = 400, y = 250;
    int dx = 10, dy = 10;
    int mouseOffsetX, mouseOffsetY;
    
    
    public MyPanel(){
        
        addMouseListener(new MouseAdapter() {
                    public void mousePressed(MouseEvent e) {

                        if (e.getX() >= x && e.getX() <= x + 50 && e.getY() >= y && e.getY() <= y + 40) {
                            
                            if(th == null){
                                th = new Thread(MyPanel.this);
                                th.start();
                            }
                            
                            mouseOffsetX = e.getX() - x;
                            mouseOffsetY = e.getY() - y;
                        }
                    }

                    public void mouseReleased(MouseEvent e) {
                        th.suspend();
                    }
                });

                addMouseMotionListener(new MouseAdapter() {
                    public void mouseDragged(MouseEvent e) {
                                                
                        x = e.getX() - mouseOffsetX;
                        y = e.getY() - mouseOffsetY;

                        if (x < 0) {
                            x = 0;
                        }
                        if (y < 0) {
                            y = 0;
                        }
                        if (x + 50 > getWidth()) {
                            x = getWidth() - 50;
                        }
                        if (y + 40 > getHeight()) {
                            y = getHeight() - 40;
                        }

                        repaint();
                    }
                });
        }
    
    public void paint(Graphics g){
        
        super.paint(g);
        g.setColor(Color.RED);
        g.fillOval(x, y, 50, 40);
    }
    
    public void run() {
        while (true) {
            try {

                repaint();
                Thread.sleep(30);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}




