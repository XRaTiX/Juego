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
    String level = session.getAttribute("nivel").toString();
    String correct = request.getParameter("correct");
    String incorrect =request.getParameter("incorrect");
    st.executeUpdate("update usuarios_puntajes set nivel"+level+"_correctos = '"+correct+"',nivel"+level+"_incorrectos = '"+incorrect+"' where ID = '"+session.getAttribute("id") +"'");
    session.setAttribute("quiz",level);
    response.sendRedirect("quiz.jsp");
    
%>