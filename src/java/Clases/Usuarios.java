package Clases;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;

public class Usuarios {
    
    Database database = new Database();
    String nombre_bd = database.nombre_bd();
    String usuarioBD="";
    String passwordBD="";
    String puenteJDBC = "net.ucanaccess.jdbc.UcanaccessDriver"; //Se declara el driver JDBC a utilizar
    Connection con;
    Statement st1,st2,st3;
    ResultSet rs1,rs2,rs3;
    public Usuarios() throws ClassNotFoundException, SQLException 
    {
        Class.forName(puenteJDBC);
        con = DriverManager.getConnection("jdbc:ucanaccess://"+nombre_bd,usuarioBD,passwordBD);
        st1 = con.createStatement();
        st2 = con.createStatement();
        st3 = con.createStatement();
    }
    
    
    public LinkedList<Usuarios_set_get> get_Datos() throws SQLException
    {
        LinkedList<Usuarios_set_get> lista = new LinkedList();
        
        rs1 = st1.executeQuery("select * from usuarios");
        rs2 = st2.executeQuery("select * from usuarios_niveles");
        rs3 = st3.executeQuery("select * from usuarios_puntajes");
        while(rs1.next() && rs2.next() && rs3.next())
        {
            Usuarios_set_get datos = new Usuarios_set_get();
            datos.setNombre(rs1.getString("user_name"));
            datos.setId(rs1.getString("ID"));
            datos.setType(rs1.getString("user_type"));
            datos.setPassword(rs1.getString("user_password"));
            datos.setAccesoNivel1(rs2.getString("nivel1"));
            datos.setAccesoNivel2(rs2.getString("nivel2"));
            datos.setPuntajeNivel1(rs3.getString("nivel1_correctos"));
            lista.add(datos);
        }
        return lista;
        
    }
}
