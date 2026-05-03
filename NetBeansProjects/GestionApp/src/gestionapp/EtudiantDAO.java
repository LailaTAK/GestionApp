package gestionapp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EtudiantDAO {

    public void ajouter(String nom, String prenom, String email, String telephone) {
        String sql = "INSERT INTO etudiants (nom, prenom, email, telephone) VALUES (?,?,?,?)";
        try {
            Connection conn = Connexion.getConnexion();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, nom);
            ps.setString(2, prenom);
            ps.setString(3, email);
            ps.setString(4, telephone);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Erreur ajouter: " + e.getMessage());
        }
    }

    public List<String[]> lireTous() {
        List<String[]> liste = new ArrayList<>();
        String sql = "SELECT * FROM etudiants";
        try {
            Connection conn = Connexion.getConnexion();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] etudiant = {
                    rs.getString("id"),
                    rs.getString("nom"),
                    rs.getString("prenom"),
                    rs.getString("email"),
                    rs.getString("telephone")
                };
                liste.add(etudiant);
            }
        } catch (SQLException e) {
            System.out.println("Erreur lireTous: " + e.getMessage());
        }
        return liste;
    }

    public void modifier(int id, String nom, String prenom, 
                         String email, String telephone) {
        String sql = "UPDATE etudiants SET nom=?, prenom=?, email=?, telephone=? WHERE id=?";
        try {
            Connection conn = Connexion.getConnexion();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, nom);
            ps.setString(2, prenom);
            ps.setString(3, email);
            ps.setString(4, telephone);
            ps.setInt(5, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Erreur modifier: " + e.getMessage());
        }
    }

    public void supprimer(int id) {
        String sql = "DELETE FROM etudiants WHERE id = ?";
        try {
            Connection conn = Connexion.getConnexion();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Erreur supprimer: " + e.getMessage());
        }
    }

    public List<String[]> rechercher(String motCle) {
        List<String[]> liste = new ArrayList<>();
        String sql = "SELECT * FROM etudiants WHERE nom LIKE ? OR prenom LIKE ? OR email LIKE ?";
        try {
            Connection conn = Connexion.getConnexion();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + motCle + "%");
            ps.setString(2, "%" + motCle + "%");
            ps.setString(3, "%" + motCle + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] etudiant = {
                    rs.getString("id"),
                    rs.getString("nom"),
                    rs.getString("prenom"),
                    rs.getString("email"),
                    rs.getString("telephone")
                };
                liste.add(etudiant);
            }
        } catch (SQLException e) {
            System.out.println("Erreur rechercher: " + e.getMessage());
        }
        return liste;
    }

    public int compterTous() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM etudiants";
        try {
            Connection conn = Connexion.getConnexion();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) total = rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Erreur compterTous: " + e.getMessage());
        }
        return total;
    }

    public int compterAujourdhui() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM etudiants WHERE DATE(date_inscription) = CURDATE()";
        try {
            Connection conn = Connexion.getConnexion();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) total = rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Erreur compterAujourdhui: " + e.getMessage());
        }
        return total;
    }

    public List<String[]> getEtudiantsPourCombo() {
        List<String[]> liste = new ArrayList<>();
        String sql = "SELECT id, nom, prenom FROM etudiants";
        try {
            Connection conn = Connexion.getConnexion();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] e = {
                    rs.getString("id"),
                    rs.getString("nom") + " " + rs.getString("prenom")
                };
                liste.add(e);
            }
        } catch (SQLException e) {
            System.out.println("Erreur getEtudiantsPourCombo: " + e.getMessage());
        }
        return liste;
    }

    public void ajouterAbsence(int etudiantId, String date, 
                                String statut, String motif) {
        String sql = "INSERT INTO absences (etudiant_id, date_absence, statut, motif) " +
                     "VALUES (?, ?, ?, ?)";
        try {
            Connection conn = Connexion.getConnexion();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, etudiantId);
            ps.setDate(2, java.sql.Date.valueOf(date));
            ps.setString(3, statut);
            ps.setString(4, motif.isEmpty() ? null : motif);
            int rows = ps.executeUpdate();
            System.out.println("Absence insérée : " + rows + " ligne(s)");
        } catch (SQLException e) {
            System.out.println("Erreur ajouterAbsence: " + e.getMessage());
        }
    }

    public List<String[]> lireAbsences() {
        List<String[]> liste = new ArrayList<>();
        String sql = "SELECT a.id, e.nom, e.prenom, " +
                     "a.date_absence, a.statut, a.motif " +
                     "FROM absences a " +
                     "INNER JOIN etudiants e ON a.etudiant_id = e.id " +
                     "ORDER BY a.date_absence DESC";
        try {
            Connection conn = Connexion.getConnexion();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] abs = {
                    String.valueOf(rs.getInt(1)),
                    rs.getString(2) + " " + rs.getString(3),
                    rs.getString(4),
                    rs.getString(5),
                    rs.getString(6) != null ? rs.getString(6) : ""
                };
                liste.add(abs);
            }
        } catch (SQLException e) {
            System.out.println("Erreur lireAbsences: " + e.getMessage());
        }
        return liste;
    }
    public int computerAbsencesAujourdhui(){
        int total = 0;
        String sql = "SELECT COUNT(*) FROM absences WHERE date_absence= CURDATE()";
        try{
            Connection conn = Connexion.getConnexion();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) total=rs.getInt(1);
        }catch(SQLException e){
            System.out.println("Erreur: "+e.getMessage());
        }return total;
    }
    public java.util.Map<String, Integer> absencesParJour() {
    java.util.Map<String, Integer> data = new java.util.LinkedHashMap<>();
    String sql = "SELECT DATE(date_absence) as jour, COUNT(*) as total " +
                 "FROM absences " +
                 "WHERE date_absence >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) " +
                 "GROUP BY DATE(date_absence) " +
                 "ORDER BY DATE(date_absence)";
    try {
        Connection conn = Connexion.getConnexion();
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            data.put(rs.getString("jour"), rs.getInt("total"));
        }
    } catch (SQLException e) {
        System.out.println("Erreur absencesParJour: " + e.getMessage());
    }
    return data;
}
}