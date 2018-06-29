<%@page import="Clases.Database"%>
<%@ page import ="java.sql.*" %>
<%
    
    Database database = new Database();
    String nombre_bd = database.nombre_bd();
    String usuarioBD="";
    String passwordBD="";
    String id = request.getParameter("username");
    String password = request.getParameter("password");
    String name = request.getParameter("name");
    String type = request.getParameter("type");
    String pageToBack = request.getParameter("page");
    String puenteJDBC = "net.ucanaccess.jdbc.UcanaccessDriver"; //Se declara el driver JDBC a utilizar
    Class.forName(puenteJDBC);
    Connection con = DriverManager.getConnection("jdbc:ucanaccess://"+nombre_bd,usuarioBD,passwordBD);
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select * from usuarios where ID = '" + id + "' and user_password = '"+password+"' and user_name ='"+name+"'");
    if (!rs.next()) {
        ResultSet rs2 = st.executeQuery("select * from usuarios where ID = '" + id + "'");
        if(!rs2.next()){
            int i = st.executeUpdate("insert into usuarios (ID,user_password,user_name,user_type) values ('"+id+"','"+password+"','"+name+"','"+type+"')");
        i = st.executeUpdate("insert into usuarios_niveles (nivel1,nivel2,ID) values ('1','0','"+id+"')");
        st.executeUpdate("insert into usuarios_puntajes (ID,nivel1_correctos,nivel1_incorrectos,quiz1_puntajes) values ('"+id+"','0','0','0')");
        if(i==1){%>
            <script type="text/javascript">
            confirm('Usuario registrado correctamente');
            </script>
        <%
            con.close();}
            if(pageToBack.equals("AgregarUsuario")){%>
            <script type="text/javascript">
            window.location = 'Administrativo.jsp';
            </script>
  <%}          else{%>
               <script type="text/javascript">
               window.location = 'index.html';
            </script> 
  <%           
    }
        }
else{
con.close();
%>
<script type="text/javascript">
    confirm('Usuario Duplicado,intentelo de nuevo');
    window.location = 'AgregarUsuario.jsp';
</script><%
}

}
else{
%>
<script type="text/javascript">
    confirm('Usuario ya existe,intentelo de nuevo');
</script><%
    con.close();
  if(pageToBack.equals("AgregarUsuario")){
%> <script type="text/javascript">
        window.location = 'AgregarUsuario.html';
    </script><% 
} else{%>
<script type="text/javascript">
        window.location = 'index.html';
    </script> <%
}
}
  %>

    