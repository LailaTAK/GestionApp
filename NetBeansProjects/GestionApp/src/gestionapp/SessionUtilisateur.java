/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package gestionapp;

/**
 *
 * @author Laila
 */
public class SessionUtilisateur {
    private static String username;
    private static String role;
    
    public static void setUtilisateur(String u, String r){
        username = u;
        role = r;
    }
    public static String getUsername(){
        return username;
    }
    public static String getRole(){
        return role;
    }
    public static boolean isAdmin(){
        return "admin".equals(role);
    }
    public static void deconnecter(){
        username = null;
        role = null;
    }
}
