<%@page import="Clases.Database"%>
<%@ page import ="java.sql.*" %>
<%
    Database database = new Database();
    String nombre_bd = database.nombre_bd();
    String usuarioBD = "";
    String passwordBD = "";
    String[] usernames = request.getParameterValues("username");
    String[] nombres = request.getParameterValues("nombre");
    String[] passwords = request.getParameterValues("password");
    String[] types = request.getParameterValues("type");
    String[] nivel1Acceso = request.getParameterValues("nivel1Acceso");
    String[] nivel2Acceso = request.getParameterValues("nivel2Acceso");
    String[] puntajeNivel1 = request.getParameterValues("puntajeNivel1");
    String puenteJDBC = "net.ucanaccess.jdbc.UcanaccessDriver"; //Se declara el driver JDBC a utilizar
    Class.forName(puenteJDBC);
    Connection con = DriverManager.getConnection("jdbc:ucanaccess://" + nombre_bd, usuarioBD, passwordBD);
    Statement st = con.createStatement();
    int i;
    for (i = 0; i <usernames.length; i++) {
        System.out.println(usernames[i]);
        st.executeUpdate("update usuarios set ID = '" + usernames[i] + "',user_type = '" + types[i] + "',user_name = '" + nombres[i] + "',user_password = '" + passwords[i] + "' where ID = '"+usernames[i]+"'");
        st.executeUpdate("update usuarios_niveles set ID = '" + usernames[i] + "',nivel1 = '" + nivel1Acceso[i] + "', nivel2 = '" + nivel2Acceso[i] + "' where ID = '"+usernames[i]+"'");
        st.executeUpdate("update usuarios_puntajes set ID = '" + usernames[i] + "',nivel1_correctos = '" + puntajeNivel1[i] + "' where ID = '"+usernames[i]+"'");
    }
    con.close();
%>
<script type="text/javascript">
    confirm("Usuarios actualizados");
    window.location = 'Administrativo.jsp';
</script>

