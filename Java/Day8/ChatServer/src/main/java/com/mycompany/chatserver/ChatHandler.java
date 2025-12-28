/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.chatserver;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.Socket;
import java.util.Vector;

/**
 *
 * @author thaowpstasaiid
 */
public class ChatHandler extends Thread{
    Socket s;
    BufferedReader dis;
    PrintStream ps;
    static Vector<ChatHandler> clients = new Vector<ChatHandler>();
    
    public ChatHandler(Socket socket){
        s = socket;
        
        try{
            dis = new BufferedReader(new InputStreamReader(s.getInputStream()));
            ps = new PrintStream(s.getOutputStream());
            
            clients.add(this);
            
            start();
        }catch(IOException e){
          e.printStackTrace();
      }
    }
    
    public void run(){
        while(true){
            try{
                String msg = dis.readLine();
                sendMsgToAll(msg);
            }catch(IOException e){
                e.printStackTrace();
            }
        }
    }
    
    void sendMsgToAll(String str){
        for(int i = 0; i < clients.size(); i++){
            clients.get(i).ps.println(str);
        }
    }
}
