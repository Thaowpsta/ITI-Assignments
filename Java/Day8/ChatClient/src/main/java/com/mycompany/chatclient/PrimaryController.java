/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/javafx/FXMLController.java to edit this template
 */
package com.mycompany.chatclient;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.Socket;
import java.net.URL;
import java.util.ResourceBundle;
import javafx.application.Platform;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;

/**
 * FXML Controller class
 *
 * @author thaowpstasaiid
 */
public class PrimaryController implements Initializable {

    @FXML
    private Button sendMsg;
    @FXML
    private TextField textMsg;
    @FXML
    private TextArea textArea;

    Socket socket;
    BufferedReader dis;
    PrintStream ps;
    
    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
        
        textArea.setEditable(false);

         try{
            socket = new Socket("localhost", 5005);
            dis = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            ps = new PrintStream(socket.getOutputStream());
            
            String msg;
            
            Thread th = new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        String msg;
                        while ((msg = dis.readLine()) != null) {

                            final String message = msg;

                            Platform.runLater(new Runnable() {

                                public void run() {
                                    textArea.appendText(message + "\n");
                                }
                            });
                            
                        }
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            });

           th.start();

        }catch (IOException e) {
            e.printStackTrace();
        }
    }    

    @FXML
    private void sendMsg(ActionEvent event) {
        
        String msg = textMsg.getText();
        if (!msg.isEmpty()) {
            ps.println(msg);
            textMsg.clear();
        }
    }
    
}
