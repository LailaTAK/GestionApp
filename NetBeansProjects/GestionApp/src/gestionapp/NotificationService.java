/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package gestionapp;
import javax.swing.*;
import java.awt.*;
/**
 *
 * @author Laila
 */
public class NotificationService {
    public static void afficherNotification(String titre, String message,int type){
        SwingUtilities.invokeLater(()->{
            JWindow popup = new JWindow();
            popup.setAlwaysOnTop(true);
            
            JPanel panel = new JPanel(new BorderLayout());
            panel.setBorder(BorderFactory.createLineBorder(getCouleur(type),2));
            panel.setBackground(Color.WHITE);
            
            JLabel lblTitre = new JLabel(titre);
            JLabel lblMessage = new JLabel("<html><body style='width:200px'>"+message+"</body></html>");
            
            panel.add(lblTitre, BorderLayout.NORTH);
            panel.add(lblMessage, BorderLayout.CENTER);
            
            popup.add(panel);
            popup.pack();
            
            Dimension screen = Toolkit.getDefaultToolkit().getScreenSize();
            popup.setLocation(
            screen.width - popup.getWidth()-20,
            screen.height -popup.getHeight()-50
            );
            
            popup.setVisible(true);
            new Thread(()->{
                try{
                    Thread.sleep(3000);
                    popup.setVisible(false);
                    popup.dispose();
                }catch(InterruptedException e){
                    Thread.currentThread().interrupt();
                }
            }).start();
        });
    }
    
    private static Color getCouleur(int type) {
        switch (type) {
            case 0: return new Color(46, 204, 113);   // Succès - vert
            case 1: return new Color(231, 76, 60);    // Erreur - rouge
            case 2: return new Color(241, 196, 15);   // Avertissement - jaune
            default: return new Color(52, 152, 219);  // Info - bleu
        }
    }
    public static final int SUCCES = 0;
    public static final int ERREUR = 1;
    public static final int AVERTISSEMENT = 2;
    public static final int INFO = 3;
}
