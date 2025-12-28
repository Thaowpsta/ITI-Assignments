/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/javafx/FXMLController.java to edit this template
 */
package com.mycompany.contactdetails;

import java.net.URL;
import java.sql.SQLException;
import java.util.ResourceBundle;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;

/**
 * FXML Controller class
 *
 * @author thaowpstasaiid
 */
public class PrimaryController implements Initializable {

    @FXML
    private TextField idTxtF;
    @FXML
    private TextField fnameTxtF;
    @FXML
    private TextField mnameTxtF;
    @FXML
    private TextField lnameTxtF;
    @FXML
    private TextField emailTxtF;
    @FXML
    private TextField phoneTxtF;
    @FXML
    private Button add;
    @FXML
    private Button update;
    @FXML
    private Button delete;
    @FXML
    private Button fisrt;
    @FXML
    private Button next;
    @FXML
    private Button last;

    private boolean isAdding = false;
    private boolean isUpdating = false;

    private DAO db = new DAO();

    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        try {
            db.startConnection();

            Contact first = db.getFirst();
            fillFields(first);

            disableFields(true);
            disableButtons(false);

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @FXML
    private void addContact(ActionEvent event) {

        if (!isAdding) {
            isAdding = true;
            add.setText("Save");

            clearFields();
            disableFields(false);
            disableButtons(true);
            add.setDisable(false);

        } else {
            try {
                Contact c = readFields();
                db.addContact(c);

                isAdding = false;
                add.setText("New");

                disableFields(true);
                disableButtons(false);
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }
        }
    }

    @FXML
    private void updateContact(ActionEvent event) {

        if (!isUpdating) {

            isUpdating = true;
            update.setText("Save");

            disableFields(false);
            idTxtF.setDisable(true);
            disableButtons(true);
            update.setDisable(false);
        } else {
            try {
                Contact c = readFields();
                db.updateContact(c);

                isUpdating = false;
                update.setText("Update");

                disableFields(true);
                disableButtons(false);
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }

    @FXML
    private void deleteContact(ActionEvent event) {
        try {
            int id = Integer.parseInt(idTxtF.getText());

            db.deleteContact(id);

            if (db.getNext(id) != null) {
                nextContact(event);
            } else {
                clearFields();
                disableFields(true);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    @FXML
    private void firstContact(ActionEvent event) {
        try {
            fillFields(db.getFirst());
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @FXML
    private void nextContact(ActionEvent event) {
        try {
            int id = Integer.parseInt(idTxtF.getText());
            fillFields(db.getNext(id));

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    @FXML
    private void lastContact(ActionEvent event) {
        try {
            fillFields(db.getLast());
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    private Contact readFields() {
        return new Contact(
                Integer.parseInt(idTxtF.getText()),
                fnameTxtF.getText(),
                mnameTxtF.getText(),
                lnameTxtF.getText(),
                emailTxtF.getText(),
                phoneTxtF.getText()
        );
    }

    private void fillFields(Contact c) {
        if (c == null) {
            return;
        }
        idTxtF.setText(String.valueOf(c.getId()));
        fnameTxtF.setText(c.getfName());
        mnameTxtF.setText(c.getmName());
        lnameTxtF.setText(c.getlName());
        emailTxtF.setText(c.getEmail());
        phoneTxtF.setText(c.getPhone());
    }

    private void clearFields() {
        idTxtF.clear();
        fnameTxtF.clear();
        mnameTxtF.clear();
        lnameTxtF.clear();
        emailTxtF.clear();
        phoneTxtF.clear();
    }

    private void disableFields(boolean disable) {
        idTxtF.setDisable(disable);
        fnameTxtF.setDisable(disable);
        mnameTxtF.setDisable(disable);
        lnameTxtF.setDisable(disable);
        emailTxtF.setDisable(disable);
        phoneTxtF.setDisable(disable);
    }

    private void disableButtons(boolean disable) {
        add.setDisable(disable);
        update.setDisable(disable);
        delete.setDisable(disable);
        fisrt.setDisable(disable);
        next.setDisable(disable);
        last.setDisable(disable);
    }

}
