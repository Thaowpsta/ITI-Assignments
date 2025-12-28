module com.mycompany.contactdetails {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.sql;
    requires derbyclient;
    requires java.base;
    
    opens com.mycompany.contactdetails to javafx.fxml;
    exports com.mycompany.contactdetails;
}
