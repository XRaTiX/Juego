<%@page import="java.util.LinkedList"%>
<!DOCTYPE html>
<%@ page import ="Clases.*"%>
<html lang="en" >

<head>
  <meta charset="UTF-8">
  <title>Ranking</title>
 
<link href="https://fonts.googleapis.com/css?family=Roboto:400,500" rel="stylesheet">
  
  
      <link rel="stylesheet" href="scriptranking/style.css">
  
</head>

<body>

  <nav class="nav flex"></nav>

<div class="content">


  <div class="leaderboard flex column wrap">
    <div class="leaderboard-table flex column">
      <div class="leaderboard-header flex column grow">

          <div class="filter-by flex grow wrap">
            <div class="time-filter flex grow">
              <div class="row-button pointer row-button--active align-center">Global</div>
              <div class="row-button pointer align-center"><a href="ranking_nivel1.jsp">Nivel 1</a></div>
              <div class="row-button pointer align-center"><a href="ranking_nivel2.jsp">Nivel 2</a></div>
              <div class="row-button pointer align-center"><a href="ranking_nivel3.jsp">Nivel 3</a></div>
            </div>
              
              <div class="subject-filter flex grow">
           <div class="table-tab pointer flex grow justify-center align-center tab-active">
                <svg class="menu-link-icon" fill="#FFFFFF" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg">
                  <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
                </svg>
                Ranking Global</div>
            </div>
          </div>

          <div class="leaderboard-row flex align-center row--header" style="border-radius: 0 !important;">
            <div class="row-position">Posición</div>
            <div class="row-collapse flex align-center">
              <div class="row-user--header">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Usuario</div>
             <div class="row-team--header"></div>
              <div class="row-rank--header"></div>
            </div>
            <div class="row-calls">Puntos</div>
          </div>
        </div>
        
        <%
           Ranking rank = new Ranking();
           LinkedList<Ranking_set_get> lista_ranking = rank.ranking_readyGlobal();
        %>
                           <%  for (int i = 0; i < lista_ranking.size(); i++) {%>
                        <div class="leaderboard-row flex row-alt align-center">
                            <div class="row-position"><%out.print((i+1));%></div>
                            <div class="row-collapse flex align-center">
                             <div class="row-caller flex">
                            <!--<img class="avatar" src="" />-->
                                <div class="row-user"><%out.print(lista_ranking.get(i).getUsuario());%></div>
                            </div>
                                <div class="row-team"></div>
                                <div class="row-rank"></div>
                            </div>
                                <div class="row-calls"><%out.print(lista_ranking.get(i).getPuntaje());%></div>
                        </div>
                        <%
                            }
                        %>

      <div class="leaderboard-footer flex align-center">
  <!--PÃ¡gina 1 de 1 <a class="footer-btn pointer">Siguiente</a> 1 de 5-->
  <% if(Integer.parseInt((String)session.getAttribute("type")) == 2) {%>
       <a class="footer-btn pointer" href="Administrativo.jsp">Regresar</a>
       <% } %>
     <% if(Integer.parseInt((String)session.getAttribute("type")) == 1) {%>
       <a class="footer-btn pointer" href="Estudiante.jsp">Regresar</a>
       <% } %>
  <!--<a class="footer-btn pointer" href="index.html">Regresar</a>-->
      </div>

    </div>
  </div>
 
  </div>
  
</div>

<footer class="flex column align-center justify-center">
  <p></p>
  <!--<img src="" />-->
</footer>

</body>

</html>