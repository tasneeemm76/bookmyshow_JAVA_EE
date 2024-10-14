
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.mavenproject2;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;
import java.sql.SQLException;

/**
 *
 * @author Tasneem
 */
public class DBConnection {
     public static Connection getConnection() {
        Connection connection = null;
        try {
            // Load properties file
            InputStream inputStream = DBConnection.class.getClassLoader().getResourceAsStream("db.properties");
            Properties props = new Properties();
            props.load(inputStream);

            String driver = props.getProperty("db.driver");
            String url = props.getProperty("db.url");
            String user = props.getProperty("db.user");
            String password = props.getProperty("db.password");

            // Load JDBC driver
            Class.forName(driver);

            // Establish connection
            connection = DriverManager.getConnection(url, user, password);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return connection;
    }
}
