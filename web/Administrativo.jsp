<!DOCTYPE html>
<html>
  <head>
    <title>Menu</title>
	<link rel="stylesheet" href="scriptmenu/prueba.css"><!-- llamado del css -->
  </head>
  <style>
    .hidden {
       visibility: hidden;<!--  -->
    }

    .visible {
      visibility: visible;
    }

    .frame {
      position: absolute;
    }
  </style>
  <script>
  <!-- inicion de la funcion que permite las opciones -->
    function Game(gameDiv)
    {
      var frames = [];
      var framesNames = [];

      for (var i=0; i<gameDiv.childNodes.length; i++)
      {
        var id = gameDiv.childNodes[i].id;
        if (id != undefined)
        {
          var child = gameDiv.childNodes[i];
          if (child.classList.contains("frame"))
          {
            frames[id] = child;
            framesNames.push(id);
          }
        }
      }
<!-- funcion que mantiene visible las opciones -->
      function setFrameVisible(name)
      {
        frames[name].classList.remove("hidden");
        frames[name].classList.add("visible");
      }

      function setFrameHidden(name)
      {
        frames[name].classList.remove("visible");
        frames[name].classList.add("hidden");
      }

      return {
        "setFrameVisible": setFrameVisible,
        "setFrameHidden": setFrameHidden
      };
    }

    window.addEventListener("load", function ()
    {
      game = new Game(document.getElementById("game"));
    });

    var game;

  </script>
  <body><!--  contenedorque permite tomar las formas-->
  <div class="contenedor-form">
     <div id="game"class="toggle">
      <div id="main" class="frame visible">
        <h1>
          MENU PINCIPAL
         <% out.print(session.getAttribute("name").toString()); %>
        </h1>
        <button onclick="game.setFrameVisible('canvas');game.setFrameHidden('main');">
          JUGAR<!-- botones de opciones -->
        </button>
          <button onclick="game.setFrameVisible('can');game.setFrameHidden('main');">
          RANKING
        </button>
        <button onclick="game.setFrameVisible('highscores');game.setFrameHidden('main');">
          ESTADISTICA DEL JUGADOR
        </button>
        <button onclick="game.setFrameVisible('about');game.setFrameHidden('main');">
          TUTORIA
        </button>
		<button onclick="game.setFrameVisible('lex');game.setFrameHidden('main');">
          METODOLOGIA DEL JUEGO   
        </button>
        <button onclick="game.setFrameVisible('su');game.setFrameHidden('main');">
          MANTENIMIENTO
        </button>
      </div>
      <div id="su" class="frame hidden">  
	        <h1>
         MANTENIMIENTO
        </h1></br>
        <form action="AgregarUsuario.jsp"
	  <button onclick="game.setFrameVisible('main');game.setFrameHidden('su');">
          <input type="submit" value="Agregar Usuario">
        </button></br></br></br>
        </form>
	  <form action="ModificarUsuario.jsp"
	  <button onclick="game.setFrameVisible('main');game.setFrameHidden('su');">
          <input type="submit" value="Modificar Usuario">
        </button></br></br></br>
        </form>		      
	  <form action="eliminarUsuario.jsp"
	  <button onclick="game.setFrameVisible('main');game.setFrameHidden('su');">
          <input type="submit" value="Eliminar Usuario">
        </button></br></br></br>
        </form>
        <form action="ModificarNiveles.jsp"
	  <button onclick="game.setFrameVisible('main');game.setFrameHidden('su');">
          <input type="submit" value="Modificar preguntas de los niveles">
        </button></br></br></br>
        </form>
        <form action="ModificarQuiz.jsp"
	  <button onclick="game.setFrameVisible('main');game.setFrameHidden('su');">
          <input type="submit" value="Modificar preguntas de los quizes">
        </button></br></br></br>
        </form>
	  <button onclick="game.setFrameVisible('main');game.setFrameHidden('su');">
          VOLVER AL MEN&Uacute;
        </button></br></br></br>

      </div>
      <div id="canvas" class="frame hidden">
          <h1>NIVELES</h1>
	  	</br></br>
                <form action="verificarAccesoNivel.jsp">
                   	<!-- opciones dentro de jugar -->
		<button onclick="game.setFrameVisible('main');game.setFrameHidden('canvas');">
<!--		  <a id="nivel1" href="nivel1.jsp">NIVEL 1</a>-->
                <input type="submit" name="id" value="nivel1">
                </button></br></br>
                <button onclick="game.setFrameVisible('main');game.setFrameHidden('canvas');">
		  <input type="submit" name="id" value="nivel2">
                </button></br></br>
                </form>
		
		
		<button onclick="game.setFrameVisible('main');game.setFrameHidden('canvas');">
		VOLVER AL MEN&Uacute; </button>
		</div>
<div id="can" class="frame hidden">
	  	</br></br>
			<!-- opciones dentro de jugar -->
        <h1>
         RANKING
        </h1></br>
        <form action="ranking_global.jsp"
	  <button onclick="game.setFrameVisible('main');game.setFrameHidden('can');">
            <input type="submit" value="Ranking">
            </button></br></br></br>
        </form>
                        
		<button onclick="game.setFrameVisible('main');game.setFrameHidden('can');">
		VOLVER AL MEN&Uacute; </button>

      </div>
      <div id="highscores" class="frame hidden">
        <h1>
         ESTADISTICAS 
        </h1>
        <form action="estadistica_jugador.jsp">
            <button onclick="game.setFrameVisible('main');game.setFrameHidden('canvas');">
<!--		  <a id="nivel1" href="nivel1.jsp">NIVEL 1</a>-->
                <input type="submit" value="Mis Estadisticas">
            </button></br></br>
        </form>
        <form action="buscar_jugador.jsp">
           <button onclick="game.setFrameVisible('main');game.setFrameHidden('canvas');">
      	   <input type="submit" name="id" value="Buscar estadisticas de un jugador">
           </button></br></br>           
          </form>
            
        <button onclick="game.setFrameVisible('main');game.setFrameHidden('highscores');">
          VOLVER AL MEN&Uacute;
        </button>
      </div>
      <div id="lex" class="frame hidden">
        <h1>
           METODOLOGIA DEL JUEGO 
        </h1>
        <button onclick="game.setFrameVisible('main');game.setFrameHidden('lex');">
         VOLVER AL MEN&Uacute;
        </button>
      </div>
      <div id="about" class="frame hidden">
        <h1>
           TUTORIA
        </h1>
        <button onclick="game.setFrameVisible('main');game.setFrameHidden('about');">
         VOLVER AL MEN&Uacute;
        </button>
      </div>
    </div>
  </div>

  </body>
</html>