/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package gestionapp;
 import java.sql.Connection;
 import java.sql.DriverManager;
 import java.sql.SQLException;

/**
 *
 * @author Laila
 */
public class Connexion {
    private static final String URL = "jdbc:mysql://localhost:3306/gestion_db";
    private static final String USER = "javauser";
    private static final String PASSWORD = "1234";
    
    public static Connection getConnexion() {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Connexion réussi !");
        } catch (SQLException e){
            System.out.println("Erreur de connexion : " + e.getMessage());
        }
        return conn;
    }
    
}
