<%@page import="Clases.Database"%>
<%@ page import ="java.sql.*" %>
<%
    Database database = new Database();
    String nombre_bd = database.nombre_bd();
    String usuarioBD="";
    String passwordBD="";
    String puenteJDBC = "net.ucanaccess.jdbc.UcanaccessDriver"; //Se declara el driver JDBC a utilizar
    Class.forName(puenteJDBC);
    Connection con = DriverManager.getConnection("jdbc:ucanaccess://"+nombre_bd,usuarioBD,passwordBD);
    Statement st = con.createStatement();
    String pageToBack = session.getAttribute("type").toString();
    String puntaje = request.getParameter("puntaje");
    String quiz = session.getAttribute("quiz").toString(); 
    st.executeUpdate("update usuarios_puntajes set quiz"+quiz+"_puntajes = '"+puntaje+"' where ID = '"+session.getAttribute("id") +"'");
    session.removeAttribute("quiz");
    st.executeUpdate("update usuarios_niveles set nivel2 = '1' where ID = '"+session.getAttribute("id")+"'");
    if(pageToBack.equals("1")){
        response.sendRedirect("Estudiante.jsp");
    }
    else{
        response.sendRedirect("Administrativo.jsp");
    }
%>