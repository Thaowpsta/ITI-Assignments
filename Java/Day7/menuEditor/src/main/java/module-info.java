module com.mycompany.menueditor {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.base;

    opens com.mycompany.menueditor to javafx.fxml;
    exports com.mycompany.menueditor;
}
