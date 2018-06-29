
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head> 
<meta http-equiv="Content-Type" content="text/html"/>
<title>Login result
 <%String usuario = request.getParameter("Usuario"); %> 
 <%String password = request.getParameter("password");%> 
 <% if(usuario.equals("usua") && password.equals("123"))%>
   <title> <% { out.println("Hola Denisse"  );} %></title> 
</head>
<body>
 <a href="menu.html">Mundo  del Folklore</a> 
</body>

</html>