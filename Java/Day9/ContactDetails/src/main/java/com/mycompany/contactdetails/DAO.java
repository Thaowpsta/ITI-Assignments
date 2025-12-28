/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.contactdetails;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.apache.derby.jdbc.ClientDriver;

/**
 *
 * @author thaowpstasaiid
 */
public class DAO {

    Connection connection;

    public void startConnection() throws SQLException {

        DriverManager.registerDriver(new ClientDriver());
        connection = DriverManager.getConnection("jdbc:derby://localhost:1527/ContactList", "root", "root");
    }

    public void closeConnection() throws SQLException {
        if (connection != null) {
            connection.close();
        }
    }

    public void addContact(Contact c) throws SQLException {

        String query = "INSERT INTO CONTACT_INFO (id, fname, mname, lname, email, phone) VALUES (?, ?, ?, ?, ?, ?)";

        PreparedStatement ps = connection.prepareStatement(query);

        ps.setInt(1, c.getId());
        ps.setString(2, c.getfName());
        ps.setString(3, c.getmName());
        ps.setString(4, c.getlName());
        ps.setString(5, c.getEmail());
        ps.setString(6, c.getPhone());

        ps.executeUpdate();
        ps.close();
    }

    public void updateContact(Contact c) throws SQLException {

        String query = "UPDATE CONTACT_INFO SET fname=?, mname=?, lname=?, email=?, phone=? WHERE id=?";

        PreparedStatement ps = connection.prepareStatement(query);

        ps.setString(1, c.getfName());
        ps.setString(2, c.getmName());
        ps.setString(3, c.getlName());
        ps.setString(4, c.getEmail());
        ps.setString(5, c.getPhone());
        ps.setInt(6, c.getId());
        
        ps.executeUpdate();
        ps.close();
    }

    public void deleteContact(int id) throws SQLException {

        String query = "DELETE FROM CONTACT_INFO WHERE id=?";

        PreparedStatement ps = connection.prepareStatement(query);
        ps.setInt(1, id);

        ps.executeUpdate();
        ps.close();
    }

    private Contact saveContact(ResultSet rs) throws SQLException {

        Contact c = new Contact(
                rs.getInt(1),
                rs.getString(2),
                rs.getString(3),
                rs.getString(4),
                rs.getString(5),
                rs.getString(6)
        );

        c.setId(rs.getInt(1));
        return c;
    }

    public Contact getFirst() throws SQLException {

        String query = "SELECT * FROM CONTACT_INFO FETCH FIRST ROW ONLY";
        PreparedStatement ps = connection.prepareStatement(query);
        ResultSet rs = ps.executeQuery();

        Contact c = null;
        if (rs.next()) {
            c = saveContact(rs);
        }

        rs.close();
        ps.close();
        return c;
    }

    public Contact getNext(int currentId) throws SQLException {

        String query = "SELECT * FROM CONTACT_INFO WHERE id > ? FETCH FIRST ROW ONLY";

        PreparedStatement ps = connection.prepareStatement(query);
        ps.setInt(1, currentId);
        ResultSet rs = ps.executeQuery();

        Contact c = null;
        if (rs.next()) {
            c = saveContact(rs);
        }

        rs.close();
        ps.close();
        return c;
    }

    public Contact getLast() throws SQLException {

        String query = "SELECT * FROM CONTACT_INFO FETCH LAST ROW ONLY";
        PreparedStatement ps = connection.prepareStatement(query);
        ResultSet rs = ps.executeQuery();

        Contact c = null;
        if (rs.next()) {
            c = saveContact(rs);
        }

        rs.close();
        ps.close();
        return c;
    }

}
