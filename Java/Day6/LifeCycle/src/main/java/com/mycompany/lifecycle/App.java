package com.mycompany.lifecycle;
import javafx.application.Application;
import javafx.stage.Stage;
import javafx.scene.layout.StackPane;
import javafx.scene.text.Text;
import javafx.scene.Scene;

public class App extends Application{
    
    public static void main(String[] args){
        launch(args);
    }

    public App(){
        String name = Thread.currentThread().getName();
        System.out.println("Constructor method with thread named: " + name);
    }

    @Override
    public void init() throws Exception{
        super.init();
        String name = Thread.currentThread().getName();
        System.out.println("init method with thread named: " + name);  
    }

    @Override
    public void stop() throws Exception{
        super.stop();
        String name = Thread.currentThread().getName();
        System.out.println("stop method with thread named: " + name);  
    }

    @Override
    public void  start(Stage primaryStage){
        String name = Thread.currentThread().getName();
        System.out.println("start method with thread named: " + name); 

        StackPane root = new StackPane();
        root.getChildren().add(new Text("Testing"));

        Scene scene = new Scene(root, 500, 500);
        primaryStage.setScene(scene);
        primaryStage.show();
    }
}
