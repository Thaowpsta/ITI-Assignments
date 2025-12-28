/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.chatserver;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintStream;
import java.net.ServerSocket;
import java.net.Socket;

/**
 *
 * @author thaowpstasaiid
 */
public class ChatServer {

    ServerSocket serverSocket;
    Socket s;

    
    public ChatServer(){
        
        try{
            serverSocket = new ServerSocket(5005);
            
            while(true){
                s = serverSocket.accept();
                new ChatHandler(s);
            }
        }catch(IOException e){
          e.printStackTrace();
          }
        finally{
          try{
              s.close();
              serverSocket.close();
                }catch(Exception e){
                    e.printStackTrace();
            }
        }
    }

    
    
    public static void main(String[] args) {
        new ChatServer();
    }
}
