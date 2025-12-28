import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JButton;
import java.awt.Graphics;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

class MyFrame {
    public static void main(String[] args) {

        JFrame frame = new JFrame();

        frame.setTitle("First Frame");
        frame.setSize(500, 500);

        ButtonPanel panel = new ButtonPanel();
        frame.setContentPane(panel);

        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
    }
}

class ButtonPanel extends JPanel {

    int x = 0;
    JButton incButton;
    JButton decButton;

    public ButtonPanel() {

        incButton = new JButton("Increment");
//        incButton.addActionListener(new ActionListener() {
//            public void actionPerformed(ActionEvent e) {
//                x++;
//                repaint();
//            }
//        });
        
        incButton.addActionListener(event -> {
            x++;
            repaint();
        });

        decButton = new JButton("Decrement");
//        decButton.addActionListener(new ActionListener() {
//            public void actionPerformed(ActionEvent e) {
//                x--;
//                repaint();
//            }
//        });

        decButton.addActionListener(event -> {
            x--;
            repaint();
        });

        add(incButton);
        add(decButton);
    }

    @Override
    public void paint(Graphics g) {
        super.paint(g);
        g.drawString("Count = " + x, 250, 250);
    }
}
