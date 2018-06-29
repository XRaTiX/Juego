/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

/**
 *
 * @author Roberto
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;

public class Ranking
{
    Database database = new Database();
    String nombre_bd = database.nombre_bd();
    String usuarioBD="";
    String passwordBD="";
    //String username = request.getParameter("username");
    //String password = request.getParameter("puntaje");
    String puenteJDBC = "net.ucanaccess.jdbc.UcanaccessDriver"; //Se declara el driver JDBC a utilizar
    Connection con;
    Statement st;
    ResultSet rs;
    
    public Ranking() throws ClassNotFoundException, SQLException 
    {
        Class.forName(puenteJDBC);
        con = DriverManager.getConnection("jdbc:ucanaccess://"+nombre_bd,usuarioBD,passwordBD);
        st = con.createStatement();
    }


    public LinkedList<Ranking_set_get> ranking_ready() throws SQLException
    {
        LinkedList<Ranking_set_get> lista;
        lista = new LinkedList();
        rs = st.executeQuery("select * from usuarios_puntajes order by quiz1_puntajes desc");

        while(rs.next())
        {
            Ranking_set_get ranking = new Ranking_set_get();
            ranking.setUsuario(rs.getString("ID"));
            ranking.setPuntaje(rs.getInt("quiz1_puntajes"));
            lista.add(ranking);
        }
        return lista;
    }

}

