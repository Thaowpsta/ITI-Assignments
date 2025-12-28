/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.simpleclient;

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
public class SimpleClient {

    Socket s;
    BufferedReader dis;
    PrintStream ps;
    
    public SimpleClient(){
      try{
          
              s = new Socket("127.0.0.1", 5005);
              
              
              dis = new BufferedReader(new InputStreamReader(s.getInputStream()));
              ps = new PrintStream(s.getOutputStream());
              
              ps.println("Test Test");
                            
              String msg = dis.readLine();
              
              System.out.println("From client class: " + msg);
              
      }catch(IOException e){
          e.printStackTrace();
      }
      finally{
          try{
              ps.close();
              dis.close();
              s.close();
          }catch(Exception e){
            e.printStackTrace();
          }
      }
    }

    public static void main(String[] args) {
        new SimpleClient();
    }
}
