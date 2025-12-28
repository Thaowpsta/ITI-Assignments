/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.simpleserver;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.ServerSocket;
import java.net.Socket;
/**
 *
 * @author thaowpstasaiid
 */
public class SimpleServer {
    ServerSocket serverSocket;
    Socket s;
    BufferedReader dis;
    PrintStream ps;
    
    public SimpleServer(){
      try{
          serverSocket = new ServerSocket(5005);
          
              s = serverSocket.accept();
              
              dis = new BufferedReader(new InputStreamReader(s.getInputStream()));
              ps = new PrintStream(s.getOutputStream());
              
              String msg = dis.readLine();
              
              System.out.println("From server class: " + msg);
              
              ps.println("Data Recieved");

      }catch(IOException e){
          e.printStackTrace();
      }
      finally{
          try{
              ps.close();
              dis.close();
              s.close();
              serverSocket.close();
          }catch(Exception e){
            e.printStackTrace();
          }
      }
    }
    
    
    public static void main(String[] args) {
        new SimpleServer();
    }
}
