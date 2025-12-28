import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Graphics;
import java.awt.Color;
import java.awt.event.MouseEvent;
import java.awt.event.MouseAdapter;
import java.util.ArrayList;

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
    ArrayList<Line> lines = new ArrayList<>();
    Line currentLine;
    
    int prevX, prevY, currX, currY;

    public MyPanel(){
        th = new Thread(this);
        th.start();
        th.suspend();
        
        addMouseListener(new MouseAdapter() {
            public void mousePressed(MouseEvent e) {
                    prevX = e.getX();
                    prevY = e.getY();
                    currX = prevX;
                    currY = prevY;
                    
                    th.resume();
            }
            
            public void mouseReleased(MouseEvent e) {

                    lines.add(new Line(prevX, prevY, currX, currY));

                    currentLine = null;
                    th.suspend();
                    repaint();
            }
        });

        addMouseMotionListener(new MouseAdapter() {
            public void mouseDragged(MouseEvent e) {
                
                    currX = e.getX();
                    currY = e.getY();
                    
                    currentLine = new Line(prevX, prevY, currX, currY);
            }
        });
    }
    
    public void paint(Graphics g){
        super.paint(g);
        g.setColor(Color.blue);
        
        for(Line line : lines) {
            g.drawLine(line.x1, line.y1, line.x2, line.y2);
        }
        
        if(currentLine != null) {
            g.drawLine(currentLine.x1, currentLine.y1, currentLine.x2, currentLine.y2);
        }
        
        g.setColor(Color.black);
    }
    
    public void run() {
        while(true) {
            try {
                repaint();
                Thread.sleep(30);
            } catch(InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

