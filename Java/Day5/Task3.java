import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Graphics;
import java.awt.Color;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

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
    
    JButton startBtn;
    JButton pauseBtn;
    

    int x = 400, y = 250;
    int dx = 10, dy = 10;
    
    
    public MyPanel(){
        
        startBtn = new JButton("Start");
        pauseBtn = new JButton("Pause");
        
        startBtn.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                
                if(th == null){
                    th = new Thread(MyPanel.this);
                    th.start();
                }else{
                    th.resume();
                }
            }
        });
        
        pauseBtn.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                th.suspend();
            }
        });
      
        
        add(startBtn);
        add(pauseBtn);
    }
    
    public void paint(Graphics g){
        
        super.paint(g);
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




