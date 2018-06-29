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
              <div class="row-button pointer align-center"><a href="ranking_global.jsp">Global</a></div>
              <div class="row-button pointer align-center"><a href="ranking_nivel1.jsp">Nivel 1</a></div>
              <div class="row-button pointer row-button--active align-center">Nivel 2</div>
              <div class="row-button pointer align-center"><a href="ranking_nivel3.jsp">Nivel 3</a></div>
            </div>
          </div>

          <div class="leaderboard-row flex align-center row--header" style="border-radius: 0 !important;">
            <div class="row-position">Posición</div>
            <div class="row-collapse flex align-center">
              <div class="row-user--header">Usuario</div>
             <div class="row-team--header"></div>
              <div class="row-rank--header"></div>
            </div>
            <div class="row-calls">Puntos</div>
          </div>
        </div>


     <%
           Ranking rank = new Ranking();
           LinkedList<Ranking_set_get> lista_ranking = rank.ranking_ready();
           int posicion = 1;
        %>
                           <%  for (int i = 0; i < lista_ranking.size(); i++) {%>
                        <div class="leaderboard-row flex row-alt align-center">
                            <div class="row-position"><%out.print(posicion+posicion);%></div>
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
  <!--Página 1 de 1 <a class="footer-btn pointer">Siguiente</a> 1 de 5-->
      </div>

    </div>
  </div>

  </div>
  
</div>

<footer class="flex column align-center justify-center">
  <p></p>
  <!--<img src="" />-->
</footer>
 

    <script  src="js/index.js"></script>


</body>

</html>