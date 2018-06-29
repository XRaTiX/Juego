<%@page import="Clases.Database"%>
<%@ page import ="java.sql.*" %>
<%
    Database database = new Database();
    String nombre_bd = database.nombre_bd();
    String usuarioBD = "";
    String passwordBD = "";
    String nivel_apretado = request.getParameter("id");
    String puenteJDBC = "net.ucanaccess.jdbc.UcanaccessDriver"; //Se declara el driver JDBC a utilizar
    Class.forName(puenteJDBC);
    Connection con = DriverManager.getConnection("jdbc:ucanaccess://" + nombre_bd, usuarioBD, passwordBD);
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select " + nivel_apretado + " from usuarios_niveles where ID = '" + session.getAttribute("id").toString() + "'");
    rs.next();
    String nivel = rs.getString(nivel_apretado);
    if (nivel.equals("1")){
        session.setAttribute("nivel",nivel_apretado.toString().substring(5));
        con.close();
        response.sendRedirect("nivel.jsp");
    }
    else{
        con.close();
%> <script type="text/javascript">
    confirm("Todavia no tienes acceso a este nivel");
    window.location = 'redirectuser.jsp';
</script>
<% }%>