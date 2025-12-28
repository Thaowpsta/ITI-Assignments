import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Graphics;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;

class MyFrame {
    public static void main(String[] args) {

        JFrame frame = new JFrame();

        frame.setTitle("First Frame");
        frame.setSize(500, 500);

        MyPanel panel = new MyPanel();
        frame.setContentPane(panel);

        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
    }
}

class MyPanel extends JPanel {

    int x = 200;
    int y = 250;
    String text = "Java";

    public MyPanel() {

        setFocusable(true);

        addKeyListener(new KeyAdapter(){
            public void keyPressed(KeyEvent e){
                int key = e.getKeyCode();
                if(key == KeyEvent.VK_UP && y > 15){
                    y -= 10;
                }
                if(key == KeyEvent.VK_LEFT && x > 5){
                    x -= 10;
                }
                if(key == KeyEvent.VK_DOWN && y < (500 - 30)){
                    y += 10;
                }
                if(key == KeyEvent.VK_RIGHT && x < (500 - 35)){
                    x += 10;
                }
                
                repaint();
            }
        });
    }

    @Override
    public void paintComponent(Graphics g) {
        super.paintComponent(g);
        g.drawString(text, x, y);
    }
}

