<%@page import="Clases.Database"%>
<%@ page import ="java.sql.*" %>
<%
    Database database = new Database();
    String nombre_bd = database.nombre_bd();
    String usuarioBD = "";
    String passwordBD = "";
    String id = request.getParameter("username");
    String puenteJDBC = "net.ucanaccess.jdbc.UcanaccessDriver"; //Se declara el driver JDBC a utilizar
    Class.forName(puenteJDBC);
    Connection con = DriverManager.getConnection("jdbc:ucanaccess://" + nombre_bd, usuarioBD, passwordBD);
    Statement st = con.createStatement();
    System.out.println(id); 
    int i = st.executeUpdate("delete from usuarios where ID = '" + id + "'");
    st.executeUpdate("delete from usuarios_niveles where ID = '" + id + "'");
    st.executeUpdate("delete from usuarios_puntajes where ID = '" + id + "'");
    if (i == 1)
        con.close();
%>
<script type="text/javascript">
    confirm('Usuario eliminado correctamente');
    window.location = 'Administrativo.jsp';
</script>