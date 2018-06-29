<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Integer type = Integer.parseInt( (String) session.getAttribute("type"));
    String redirectURL = "";
    switch(type){
        case 1: redirectURL = "Estudiante.jsp";
                break;
        case 2: redirectURL = "Administrativo.jsp";
                break;
    }
    response.sendRedirect(redirectURL);
%>