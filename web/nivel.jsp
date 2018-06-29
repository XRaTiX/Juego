<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

<%@page import="Clases.Database"%>
<%@ page import ="java.sql.*" %>
<%
    Database database = new Database();
    String nombre_bd = database.nombre_bd();
    String usuarioBD = "";
    String passwordBD = "";
    String puenteJDBC = "net.ucanaccess.jdbc.UcanaccessDriver"; //Se declara el driver JDBC a utilizar
    Class.forName(puenteJDBC);
    Connection con = DriverManager.getConnection("jdbc:ucanaccess://" + nombre_bd, usuarioBD, passwordBD);
    Statement st = con.createStatement();
    
%>
<html>
    <head>
        <title>Nivel <%out.print(session.getAttribute("nivel"));%></title>
        <style type="text/css">
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
        <script type="text/javascript" src="/main.js" charset="UTF-8"></script><link rel="stylesheet" href="/main.css"/><script type="text/javascript">

            var shuffleQuestions = true;	/* Shuffle questions ? */
            var shuffleAnswers = true;	/* Shuffle answers ? */
            var lockedAfterDrag = false;	/* Lock items after they have been dragged, i.e. the user get's only one shot for the correct answer */
            function quizIsFinished()
            {
                alert('El boton de enviar a sido habilitado,puedes apretarlo para saber tus datos de este nivel');
            }


            /* Don't change anything below here */
            var dragContentDiv = false;
            var dragContent = false;

            var dragSource = false;
            var dragDropTimer = -1;
            var destinationObjArray = new Array();
            var destination = false;
            var dragSourceParent = false;
            var dragSourceNextSibling = false;
            var answerDiv;
            var questionDiv;
            var sourceObjectArray = new Array();
            var arrayOfEmptyBoxes = new Array();
            var arrayOfAnswers = new Array();
            var countCorrectAnswers = 0;
            var countWrongAnswers = 0;
            var finish = false;
            function getTopPos(inputObj)
            {
                if (!inputObj || !inputObj.offsetTop)
                    return 0;
                var returnValue = inputObj.offsetTop;
                while ((inputObj = inputObj.offsetParent) != null)
                    returnValue += inputObj.offsetTop;
                return returnValue;
            }

            function getLeftPos(inputObj)
            {
                if (!inputObj || !inputObj.offsetLeft)
                    return 0;
                var returnValue = inputObj.offsetLeft;
                while ((inputObj = inputObj.offsetParent) != null)
                    returnValue += inputObj.offsetLeft;
                return returnValue;
            }

            function cancelEvent()
            {
                return false;
            }

            function initDragDrop(e)
            {
                if (document.all)
                    e = event;
                if (lockedAfterDrag && this.parentNode.parentNode.id == 'questionDiv')
                    return;
                dragContentDiv.style.left = e.clientX + Math.max(document.documentElement.scrollLeft, document.body.scrollLeft) + 'px';
                dragContentDiv.style.top = e.clientY + Math.max(document.documentElement.scrollTop, document.body.scrollTop) + 'px';
                dragSource = this;
                dragSourceParent = this.parentNode;
                dragSourceNextSibling = false;
                if (this.nextSibling)
                    dragSourceNextSibling = this.nextSibling;
                if (!dragSourceNextSibling.tagName)
                    dragSourceNextSibling = dragSourceNextSibling.nextSibling;

                dragDropTimer = 0;
                timeoutBeforeDrag();

                return false;
            }

            function timeoutBeforeDrag() {
                if (dragDropTimer >= 0 && dragDropTimer < 10) {
                    dragDropTimer = dragDropTimer + 1;
                    setTimeout('timeoutBeforeDrag()', 10);
                    return;
                }
                if (dragDropTimer >= 10) {
                    dragContentDiv.style.display = 'block';
                    dragContentDiv.innerHTML = '';
                    dragContentDiv.appendChild(dragSource);


                }
            }

            function dragDropMove(e)
            {
                if (dragDropTimer < 10) {
                    return;
                }

                if (document.all)
                    e = event;

                var scrollTop = Math.max(document.documentElement.scrollTop, document.body.scrollTop);
                var scrollLeft = Math.max(document.documentElement.scrollLeft, document.body.scrollLeft);

                dragContentDiv.style.left = e.clientX + scrollLeft + 'px';
                dragContentDiv.style.top = e.clientY + scrollTop + 'px';

                var dragWidth = dragSource.offsetWidth;
                var dragHeight = dragSource.offsetHeight;


                var objFound = false;

                var mouseX = e.clientX + scrollLeft;
                var mouseY = e.clientY + scrollTop;

                destination = false;
                for (var no = 0; no < destinationObjArray.length; no++) {
                    var left = destinationObjArray[no]['left'];
                    var top = destinationObjArray[no]['top'];
                    var width = destinationObjArray[no]['width'];
                    var height = destinationObjArray[no]['height'];

                    destinationObjArray[no]['obj'].className = 'destinationBox';
                    var subs = destinationObjArray[no]['obj'].getElementsByTagName('DIV');
                    if (!objFound && subs.length == 0) {
                        if (mouseX < (left / 1 + width / 1) && (mouseX + dragWidth / 1) > left && mouseY < (top / 1 + height / 1) && (mouseY + dragHeight / 1) > top) {
                            destinationObjArray[no]['obj'].className = 'dragContentOver';
                            destination = destinationObjArray[no]['obj'];
                            objFound = true;
                        }
                    }
                }

                sourceObjectArray['obj'].className = '';

                if (!objFound) {
                    var left = sourceObjectArray['left'];
                    var top = sourceObjectArray['top'];
                    var width = sourceObjectArray['width'];
                    var height = sourceObjectArray['height'];

                    if (mouseX < (left / 1 + width / 1) && (mouseX + dragWidth / 1) > left && mouseY < (top / 1 + height / 1) && (mouseY + dragHeight / 1) > top) {
                        destination = sourceObjectArray['obj'];
                        sourceObjectArray['obj'].className = 'dragContentOver';
                    }
                }
                return false;
            }


            function dragDropEnd()
            {
                if (dragDropTimer < 10) {
                    dragDropTimer = -1;
                    return;
                }
                dragContentDiv.style.display = 'none';
                sourceObjectArray['obj'].style.backgroundColor = '#FFF';
                if (destination) {
                    destination.appendChild(dragSource);
                    destination.className = 'destinationBox';

                    // Check if position is correct, i.e. correct answer to the question

                    if (!destination.id || destination.id != 'answerDiv') {
                        var previousEl = dragSource.parentNode.previousSibling;
                        if (!previousEl.tagName)
                            previousEl = previousEl.previousSibling;
                        var numericId = previousEl.id.replace(/[^0-9]/g, '');
                        var numericIdSource = dragSource.id.replace(/[^0-9]/g, '');

                        if (numericId == numericIdSource) {
                            dragSource.className = 'correctAnswer';
                            countCorrectAnswers = countCorrectAnswers + 1;
                            checkAllAnswers();
                        } else {
                            dragSource.className = 'wrongAnswer';
                            countWrongAnswers = countWrongAnswers + 1;
                        }
                    }

                    if (destination.id && destination.id == 'answerDiv') {
                        dragSource.className = 'dragDropSmallBox';
                    }

                } else {
                    if (dragSourceNextSibling)
                        dragSourceNextSibling.parentNode.insertBefore(dragSource, dragSourceNextSibling);
                    else
                        dragSourceParent.appendChild(dragSource);
                }
                dragDropTimer = -1;
                dragSourceNextSibling = false;
                dragSourceParent = false;
                destination = false;
            }

            function checkAllAnswers()
            {
                for (var no = 0; no < arrayOfEmptyBoxes.length; no++) {
                    var sub = arrayOfEmptyBoxes[no].getElementsByTagName('DIV');
                    if (sub.length == 0)
                        return;

                    if (sub[0].className != 'correctAnswer') {
                        return;
                    }

                }

                quizIsFinished();
            }



            function resetPositions()
            {
                if (dragDropTimer >= 10)
                    return;

                for (var no = 0; no < destinationObjArray.length; no++) {
                    if (destinationObjArray[no]['obj']) {
                        destinationObjArray[no]['left'] = getLeftPos(destinationObjArray[no]['obj'])
                        destinationObjArray[no]['top'] = getTopPos(destinationObjArray[no]['obj'])
                    }

                }
                sourceObjectArray['left'] = getLeftPos(answerDiv);
                sourceObjectArray['top'] = getTopPos(answerDiv);
            }


            function initDragDropScript()
            {
                dragContentDiv = document.getElementById('dragContent');

                answerDiv = document.getElementById('answerDiv');
                answerDiv.onselectstart = cancelEvent;
                var divs = answerDiv.getElementsByTagName('DIV');
                var answers = new Array();

                for (var no = 0; no < divs.length; no++) {
                    if (divs[no].className == 'dragDropSmallBox') {
                        divs[no].onmousedown = initDragDrop;
                        answers[answers.length] = divs[no];
                        arrayOfAnswers[arrayOfAnswers.length] = divs[no];
                    }

                }

                if (shuffleAnswers) {
                    for (var no = 0; no < (answers.length * 10); no++) {
                        var randomIndex = Math.floor(Math.random() * answers.length);
                        answerDiv.appendChild(answers[randomIndex]);
                    }
                }

                sourceObjectArray['obj'] = answerDiv;
                sourceObjectArray['left'] = getLeftPos(answerDiv);
                sourceObjectArray['top'] = getTopPos(answerDiv);
                sourceObjectArray['width'] = answerDiv.offsetWidth;
                sourceObjectArray['height'] = answerDiv.offsetHeight;


                questionDiv = document.getElementById('questionDiv');

                questionDiv.onselectstart = cancelEvent;
                var divs = questionDiv.getElementsByTagName('DIV');

                var questions = new Array();
                var questionsOpenBoxes = new Array();


                for (var no = 0; no < divs.length; no++) {
                    if (divs[no].className == 'destinationBox') {
                        var index = destinationObjArray.length;
                        destinationObjArray[index] = new Array();
                        destinationObjArray[index]['obj'] = divs[no];
                        destinationObjArray[index]['left'] = getLeftPos(divs[no])
                        destinationObjArray[index]['top'] = getTopPos(divs[no])
                        destinationObjArray[index]['width'] = divs[no].offsetWidth;
                        destinationObjArray[index]['height'] = divs[no].offsetHeight;
                        questionsOpenBoxes[questionsOpenBoxes.length] = divs[no];
                        arrayOfEmptyBoxes[arrayOfEmptyBoxes.length] = divs[no];
                    }
                    if (divs[no].className == 'dragDropSmallBox') {
                        questions[questions.length] = divs[no];
                    }

                }

                if (shuffleQuestions) {
                    for (var no = 0; no < (questions.length * 10); no++) {
                        var randomIndex = Math.floor(Math.random() * questions.length);

                        questionDiv.appendChild(questions[randomIndex]);
                        questionDiv.appendChild(questionsOpenBoxes[randomIndex]);

                        destinationObjArray[destinationObjArray.length] = destinationObjArray[randomIndex];
                        destinationObjArray.splice(randomIndex, 1);

                        questionsOpenBoxes[questionsOpenBoxes.length] = questionsOpenBoxes[randomIndex];
                        questionsOpenBoxes.splice(randomIndex, 1);
                        questions[questions.length] = questions[randomIndex];
                        questions.splice(randomIndex, 1);


                    }
                }

                questionDiv.style.visibility = 'visible';
                answerDiv.style.visibility = 'visible';

                document.documentElement.onmouseup = dragDropEnd;
                document.documentElement.onmousemove = dragDropMove;
                setTimeout('resetPositions()', 150);
                window.onresize = resetPositions;
            }
            function validateButton() {

                for (var no = 0; no < arrayOfEmptyBoxes.length; no++) {
                    var sub = arrayOfEmptyBoxes[no].getElementsByTagName('DIV');
                    if (sub.length == 0) {
                        finish = false;
                    } else {
                        alert('Obtuviste ' + countCorrectAnswers + ' correctos  y te equivocaste ' + countWrongAnswers + ' veces');
                        return true;
                    }


                }
                if (finish === false) {
                    alert('Debes completar el nivel antes de enviar los resultados');
                    return false;
                }
            }


            function sendData() {
                document.getElementById("correct").value = countCorrectAnswers;
                document.getElementById("incorrect").value = countWrongAnswers;
            }

            window.onload = initDragDropScript;

        </script>

    </head>
    <body>
        <div id="dragScriptContainer">

            <div class="konaBody">
                <%
                    ResultSet rs = st.executeQuery("select * from preguntas_niveles where nivel = '"+session.getAttribute("nivel")+"'");
                    rs.next();
                %>
                <div id="description">
                    <h1>Nivel <%out.print(session.getAttribute("nivel"));%></h1>
                    <h2>APRENDE METODOLOGIA XP </h2>
                    <p>Arrastra las respuestas correctas al cuadro que se te presenta verde son respuestas correcta rojo son respuestas incorrectas</p>	</div>
            </div>
            </br></br>
            <div id="questionDiv">
                <h2> Preguntas</h2>
                <h2>LOLOLOLOLjjjjjj</h2>
                <%
                    int i;
                    for(i=1;i<=2;i++){%>
                    <div class="dragDropSmallBox" id="q<% String.valueOf(i);%>"><%out.print(rs.getString("pregunta"+i));%></div>
                    <div class="destinationBox"></div>
                 <%}
                %>
<!--                <div class="dragDropSmallBox" id="q1">Siglas de Xtreme Programing</div>
                <div class="destinationBox"></div>
                <div class="dragDropSmallBox" id="q2">Cuantos Ciclos posee XP</div>
                <div class="destinationBox"></div>-->
<!--                <div class="dragDropSmallBox" id="q3">Cuantos Roles posee XP</div>
                <div class="destinationBox"></div>
                <div class="dragDropSmallBox" id="q4">Correccion de todos los errores</div>
                <div class="destinationBox"></div>
                <div class="dragDropSmallBox" id="q5">Pruebas unitarias continuas</div>
                <div class="destinationBox"></div>
                <div class="dragDropSmallBox" id="q6">La simplicidad y la comunicacion</div>
                <div class="destinationBox"></div>
                <div class="dragDropSmallBox" id="q7"> identifica que se debe hacer y que no se debe hacer</div>
                <div class="destinationBox"></div>
                <div class="dragDropSmallBox" id="q9">Desventajas</div>
                <div class="destinationBox"></div>
                <div class="dragDropSmallBox" id="q10">Que principio sigue el Diseno XP</div>
                <div class="destinationBox"></div>
                <div class="dragDropSmallBox" id="q11">XP estimula el uso de tarjetas</div>
                <div class="destinationBox"></div>
                <div class="dragDropSmallBox" id="q14"> CRC</div>
                <div class="destinationBox"></div>
                <div class="dragDropSmallBox" id="q15"> Elemento que menciona XP referentes a la codificacion</div>
                <div class="destinationBox"></div>-->

            </div>


            <div id="answerDiv">
                </br>
                <h2> Respuestas</h2></br></br>
                <%
                    for(i=1;i<=2;i++){%>
                      <div class="dragDropSmallBox" id="a<%String.valueOf(i);%>"><%out.print(rs.getString("respuesta"+i));%></div>  
               <%     }
                %>
<!--                <div class="dragDropSmallBox" id="a1">XP</div>
                <div class="dragDropSmallBox" id="a2">4</div>-->
<!--                <div class="dragDropSmallBox" id="a3">7</div>
                <div class="dragDropSmallBox" id="a4">Antes de anadir nueva funcionalidad</div>
                <div class="dragDropSmallBox" id="a5">Frecuentemente repetidas y automatizadas</div>
                <div class="dragDropSmallBox" id="a6">Son extraordinariamente complementarias</div>
                <div class="dragDropSmallBox" id="a7">Comunicacion</div>
                <div class="dragDropSmallBox" id="a9">Altas comisiones en caso de fallar</div>
                <div class="dragDropSmallBox" id="a10">Mantenlo Sencillo (MS)</div>	
                <div class="dragDropSmallBox" id="a11">CRC como un mecanismo eficaz </div>		
                <div class="dragDropSmallBox" id="a14">clase-responsabilidad-colaborador</div>	
                <div class="dragDropSmallBox" id="a15">Cliente siempre presente</div>	-->
<!--                <div class="dragDropSmallBox" id="a9">Demasiado costoso e innecesario</div>	
                <div class="dragDropSmallBox" id="a8">Satisfaccion del programador</div>	
                <div class="dragDropSmallBox" id="a8">Versiones nuevas</div>	
                <div class="dragDropSmallBox" id="a16">9</div>	
                <div class="dragDropSmallBox" id="a17">5</div>	
                <div class="dragDropSmallBox" id="a18">Programador</div>
            </div>-->

        </div>
        <div id="dragContent"></div>
        <form name="enviar" action="enviandoPuntajes.jsp" onsubmit="return validateButton()" method="post">
            <input type="hidden" id ="correct" value = "" name="correct">
            <input type="hidden" id = "incorrect" value = "" name="incorrect">
            <input type="submit" onclick="sendData()" value="Enviar">
        </form>
    </body>
</html>