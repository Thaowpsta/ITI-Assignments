package com.mycompany.helloworld;


import javafx.application.Application;
import static javafx.application.Application.launch;
import javafx.scene.Scene;
import javafx.scene.effect.Reflection;
import javafx.scene.layout.StackPane;
import javafx.scene.paint.Color;
import javafx.scene.paint.CycleMethod;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.Text;
import javafx.stage.Stage;

public class App extends Application{
    
    public static void main(String[] args){
        launch(args);
    }

    @Override
    public void  start(Stage primaryStage){
         StackPane root = new StackPane();
        Reflection reflection = new Reflection();
        
        Text text = new Text("Hello World");

//        text.setFill(Color.RED);
//        text.setFont(Font.font("Arial", FontWeight.BOLD, 40));
       
        text.getStyleClass().add("hello-text");

        text.setEffect(reflection);

        root.getChildren().add(text);

        
//        Stop[] stops = new Stop[]{
//            new Stop(0, Color.BLACK), new Stop(0.5, Color.WHITE), new Stop(1, Color.BLACK)
//        }; 
        
//        LinearGradient l1 = new LinearGradient(0, 0, 0, 1, true, CycleMethod.NO_CYCLE, stops);
        

//        Scene scene = new Scene(root, 500, 500, l1);

        Scene scene = new Scene(root, 500, 500);
        
        scene.getStylesheets().add(
        getClass().getResource("/style.css").toExternalForm()
        );

        primaryStage.setScene(scene);
        primaryStage.show();
    }
}
