module com.mycompany.chatclient {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.base;

    opens com.mycompany.chatclient to javafx.fxml;
    exports com.mycompany.chatclient;
}
