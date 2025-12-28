/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/javafx/FXMLController.java to edit this template
 */
package com.mycompany.menueditor;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.DialogPane;

import javafx.scene.control.Menu;
import javafx.scene.control.MenuItem;
import javafx.scene.control.TextArea;
import javafx.stage.FileChooser;
/**
 * FXML Controller class
 *
 * @author thaowpstasaiid
 */
public class PrimaryController implements Initializable {


    @FXML
    private Menu file;
    @FXML
    private MenuItem newFile;
    @FXML
    private MenuItem openFileHigh;
    @FXML
    private MenuItem openFileLow;
    @FXML
    private MenuItem saveFileHigh;
    @FXML
    private MenuItem saveFileLow;
    @FXML
    private MenuItem close;
    @FXML
    private MenuItem cut;
    @FXML
    private MenuItem copy;
    @FXML
    private MenuItem pasteFile;
    @FXML
    private MenuItem deleteTxt;
    @FXML
    private MenuItem selectAll;
    @FXML
    private MenuItem about;
    @FXML
    private TextArea txtArea;
    
    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
         txtArea.setEditable(false);
    }    
    
    @FXML
    private void openNewFile(ActionEvent event) {
        
        txtArea.clear();

        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("New File");
        
        fileChooser.getExtensionFilters().add(new FileChooser.ExtensionFilter("Text Files", "*.txt"));

        File file = fileChooser.showSaveDialog(null);
        
         txtArea.setEditable(true);
    }

    @FXML
    private void openFileLow(ActionEvent event) {
        
        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("Open File");
        
        File file = fileChooser.showOpenDialog(null);
        
        if(file != null){
            try{
                FileInputStream input = new FileInputStream(file);
                
                byte[] b = new byte[input.available()];
                
                input.read(b);
                
                String str = new String(b);
                
                txtArea.setText(str);
                
                input.close();
            }catch(FileNotFoundException e){
                System.out.println("Error");
            }catch(IOException e){
                System.out.println("Error");
            }
                  
        }

    }

    @FXML
    private void openFileHigh(ActionEvent event) {
        
       FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("Open File");
        
        File file = fileChooser.showOpenDialog(null);
        
        if(file != null){
            try{
               DataInputStream input = new DataInputStream(new FileInputStream(file));
                
                byte[] b = new byte[(int) file.length()];
                
                input.readFully(b);
                
                String str = new String (b);
                txtArea.setText(str);
                
                input.close();
            }catch(IOException e){
                System.out.println("Error");
            }
                  
        }
    }

    @FXML
    private void saveFileHigh(ActionEvent event) {
    
        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("Save File");
    
        fileChooser.getExtensionFilters().add(new FileChooser.ExtensionFilter("Text Files", "*.txt"));

        File file = fileChooser.showSaveDialog(null);
    
        if(file != null){
            try{
                DataOutputStream output = new DataOutputStream(new FileOutputStream(file));
            
                String str = txtArea.getText();
            
                output.writeUTF(str);
                output.close();
            
            }catch(IOException e){
                System.out.println("Error");
            }
              
        }
    }

    @FXML
    private void saveFileLow(ActionEvent event) {
    
        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("Save File");
    
        fileChooser.getExtensionFilters().add(new FileChooser.ExtensionFilter("Text Files", "*.txt"));

        File file = fileChooser.showSaveDialog(null);
    
        if(file != null){
            try{
                FileOutputStream output = new FileOutputStream(file);
            
                String content = txtArea.getText();
                byte[] b = content.getBytes();
            
                output.write(b);
            
                output.close();
            }catch(IOException e){
                System.out.println("Error");
            }
              
        }
    }

    @FXML
    private void close(ActionEvent event) {
        
        saveFileHigh(event);
        System.exit(0);
    }

    @FXML
    private void cutTxt(ActionEvent event) {
        txtArea.cut();
    }

    @FXML
    private void copyTxt(ActionEvent event) {
        txtArea.copy();
    }

    @FXML
    private void pasteFile(ActionEvent event) {
            txtArea.paste();
    }

    @FXML
    private void deleteTxt(ActionEvent event) {
        txtArea.replaceSelection("");
    }

    @FXML
    private void selectAll(ActionEvent event) {
        txtArea.selectAll();
    }

    @FXML
    private void openAbout(ActionEvent event) {
        
        Alert alert = new Alert(AlertType.INFORMATION, "Day 7 Here");
        
        alert.setTitle("About");
        
        alert.setHeaderText(null);
        alert.setGraphic(null);
    
        DialogPane dialogPane = alert.getDialogPane();
        dialogPane.setStyle("-fx-font-family: Arial; -fx-alignment: center;");
        
        alert.showAndWait();
    }

}
