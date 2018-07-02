<%@page import="Clases.Usuarios"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Clases.Usuarios_set_get"%>
<!DOCTYPE html>
<html>
    <head>
        <style type="text/css">
            table,th,td{
                border: 1px solid black;
            }
            /* DEMO CSS */
            body{

                font-family:Arial, sans-serif;	
                background-color:#d10bef;
            }
            #heading{
                height:161px;
            }

            /* END DEMO CSS */

            #dragScriptContainer{background-color:#ff851b;	/* BIG DIV containing HTML needed for the entire script 
                    width:450px;*/
                                 margin:0 auto;
                                 padding:150px;
                                 border:1px solid #9900cc;
                                 height:1000px;
                                 margin-top:20px;
                                 -moz-user-select:no;
                                 overflow:hidden;


            }
            h1,h3{
                margin:15px;
                font-family:Arial, sans-serif;
                text-align:center;
            }
            p{
                margin:2px;
                font-size:1.3em;
                font-family:Arial, sans-serif;

            }
            #questionDiv{	/* Big div for all the questions */
                float:left;
                height:100%;
                width:400px;
                padding:2px;

                visibility:hidden;	/* Initial state  - Don't change this */
            }
            #answerDiv{	/* Big div for all the answers */
                float:right;
                height:700px;
                width:400px; /*agrandar en ancho de las respuesta*/
                background:#ff851b;
                padding:2px;	

                visibility:hidden; /* Initial state  - Don't change this */
            }

            /*#questionDiv div,#answerDiv div,#dragContent div{	/* General rules for small divs - i.e. specific questions and answers 
                    width:225px;
                    height:20px;
                    line-height:20px;		
                    float:left;
                    margin-right:12px;
                    margin-bottom:12px;
                    text-align:center;
                    
            }*/
            #questionDiv div{	/* General rules for small divs - i.e. specific questions and answers */
                width:495px;
                height:20px;
                line-height:20px;		
                float:left;
                margin-right:2px;
                margin-bottom:2px;
                text-align:center;

            }
            #dragContent div{	/* General rules for small divs - i.e. specific questions and answers */
                width:295px;
                height:20px;
                padding:20px;
                line-height:20px;		
                float:left;
                /*margin-right:2px;*/
                margin-bottom:2px;
                text-align:center;

            }
            #answerDiv div{	/* General rules for small divs - i.e. specific questions and answers */
                width:395px;/*las respuestas son largas ajustarlas*/
                height:20px;
                line-height:20px;		
                float:left;
                margin-right:2px;
                margin-bottom:2px;
                text-align:center;
                background:#d10bef;

            }












            #dragContent div{	/* Drag content div - i.e. specific answers when they are beeing dragged */
                border:1px solid #d10bef;;
            }

            #answerDiv .dragDropSmallBox{border:1px solid #000;	/*	 Small answer divs 

cursor:pointer;*/
                                         background-color:#d10bef;
            }

            #questionDiv .dragDropSmallBox{	/* Small answer divs */
                border:1px solid #000;
                cursor:pointer;
                background-color:#E2EBED;
            }

            #questionDiv div div{	/* DIV after it has been dragged from right to left box */
                margin:0px;
                border:0px;
                padding:0px;
                background-color:#FFF;
                cursor:pointer;
            }
            #questionDiv .destinationBox{	/* Small empty boxes for the questions - i.e. where answers could be dragged */
                border:0px;
                background-color:#DDD;
                width:147px;	/* Width of #questionDiv div + 2 */
                height:22px;



            }
            #questionDiv .correctAnswer{	/* CSS indicating correct answer */
                background-color:green;
                color:#fff;
                border:1px solid #000;
            }
            #questionDiv .wrongAnswer{	/* CSS indicating wrong answer */
                background-color:red;
                color:#fff;
                border:1px solid #000;
            }

            #dragContent div{
                background-color:#ff851b;
            }

            #questionDiv .dragContentOver{	/* Mouse over question boxes - i.e. indicating where dragged element will be appended if mouse button is relased */
                border:1px solid #F00;background-color:#FFF;
            }

            #answerDiv.dragContentOver{	/* Mouse over answer box - i.e. indicating where dragged element will be appended if mouse button is relased */
                border:1px solid #F00;background-color:#ff851b;
            }

            /* NEVER CHANGE THIS */
            #dragContent{
                position:absolute;
                display:none;background-color:#9900cc;

            }	


        </style>
    </head>
    <body>
        <div id="dragScriptContainer">
            <div class="konaBody">
                <div id="description">
                    <h1>MODIFICAR USUARIO</h1>
                    <p>Aqui podras modificar los usuarios que desees</p>
                    <p>NOTA: Para el tipo de usuario,1 = Estandar,2 = Administrador</p>
                    <p>Para los niveles,0 = bloqueado,1 = desbloqueado</p>
                </div>
                <form action="modificarUsuariosCampos.jsp">
                    <%
                        Usuarios usuario = new Usuarios();
                        LinkedList<Usuarios_set_get> usuarios = usuario.get_Datos();
                    %>
                    <table>
                        <tr>
                            <th>Cedula</th>
                            <th>Nombre</th>
                            <th>Contraseña</th>
                            <th>Tipo de Usuario</th>
                            <th>Nivel 1 bloqueado?</th>
                            <th>Nivel 2 bloqueado?</th>
                            <th>Puntaje del Nivel 1</th>
                        </tr>
                        <% for (int i = 0; i < usuarios.size(); i++) {%>
                        <tr>
                            <td><input type="text" name ="username" value="<% out.print(usuarios.get(i).getId());%>" required></td>
                            <td><input type="text" name ="nombre" value="<% out.print(usuarios.get(i).getNombre());%>" required></td>
                            <td><input type="text" name ="password" value="<% out.print(usuarios.get(i).getPassword());%>" required></td>
                            <td><input type="number" name ="type" min="1" max="2" value="<% out.print(usuarios.get(i).getType());%>" required></td>
                            <td><input type="number" name ="nivel1Acceso" min="0" max="1" value="<% out.print(usuarios.get(i).getAccesoNivel1());%>" required></td>
                            <td><input type="number" name ="nivel2Acceso" min="0" max="1" value="<% out.print(usuarios.get(i).getAccesoNivel2());%>" required></td>
                            <td><input type="text" name ="puntajeNivel1" value="<% out.print(usuarios.get(i).getPuntajeNivel1());%>" required=></td>
                        </tr>
                        <%}%>
                    </table>
                    <input type="submit" value="Modificar Usuarios">
                </form>
                <br>
                <form action="Administrativo.jsp">
                    <input type="submit" value="Volver al menu principal">
                </form>
            </div>
        </div>
    </body>
</html>
