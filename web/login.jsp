<%@page import="Clases.Database"%>
<%@ page import ="java.sql.*" %>
<%
    Database database = new Database();
    String nombre_bd = database.nombre_bd();
    String usuarioBD="";
    String passwordBD="";
    String id = request.getParameter("username");
    String password = request.getParameter("password");
    String puenteJDBC = "net.ucanaccess.jdbc.UcanaccessDriver"; //Se declara el driver JDBC a utilizar
    Class.forName(puenteJDBC);
    Connection con = DriverManager.getConnection("jdbc:ucanaccess://"+nombre_bd,usuarioBD,passwordBD);
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select * from usuarios where ID = '" + id + "' and user_password = '" + password + "'");
    if (rs.next()) {
        String ID = rs.getString("ID");
        if (ID.equals(id) && rs.getString("user_password").equals(password)) {
            session.setAttribute("name", rs.getString("user_name"));
            session.setAttribute("type", rs.getString("user_type"));
            session.setAttribute("id", ID);
            con.close();
            response.sendRedirect("redirectuser.jsp");

        }
    } else { 
        con.close();
        %> <script type="text/javascript">
            confirm('Usuario o contraseña incorrectos,intentelo de nuevo');
            window.location = 'index.html';
        </script>
        <%}
%> 

