import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Graphics;
import java.awt.Color;
import javax.swing.JButton;
import java.awt.event.MouseEvent;
import java.awt.event.MouseAdapter;

class Line {
    int x1, y1, x2, y2;
    
    Line(int a, int b, int c, int d) {
        x1 = a;
        y1 = b;
        x2 = c;
        y2 = d;
    }
}

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
    Line l;

    int x = 400, y = 250;
    int dx = 10, dy = 10;
    int prevX, currX, prevY, currY;

    
    
    public MyPanel(){
        
        addMouseListener(new MouseAdapter() {
                    public void mousePressed(MouseEvent e) {

                        prevX = e.getX();
                        prevY = e.getY();
                    }
            });

                addMouseMotionListener(new MouseAdapter() {
                    public void mouseDragged(MouseEvent e) {
                         
                        currX = e.getX();
                        currY = e.getY();
                        
                        l = new Line(prevX, prevY, currX, currY);
                        
                        repaint();
                    }
                });
        }
    
    public void paint(Graphics g){
        
        super.paint(g);
        g.setColor(Color.blue);
        g.drawLine(l.x1, l.y1, l.x2, l.y2);
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





