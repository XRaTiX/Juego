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
<!DOCTYPE html>
<html>
    <head lang="en">
        <meta charset="UTF-8">
        <title>Quiz</title>
        <link rel="stylesheet" type="text/css" href="scriptquiz1/style.css"><!-- llamado del css -->
        <script>
            function populate() {
                if (quiz.isEnded()) {
                    showScores();
                } else {
                    // show question
                    var element = document.getElementById("question");
                    element.innerHTML = quiz.getQuestionIndex().text;

                    // show options
                    var choices = quiz.getQuestionIndex().choices;
                    for (var i = 0; i < choices.length; i++) {
                        var element = document.getElementById("choice" + i);
                        element.innerHTML = choices[i];
                        guess("btn" + i, choices[i]);
                    }

                    showProgress();
                }
            }
            ;

            function guess(id, guess) {
                var button = document.getElementById(id);
                button.onclick = function () {
                    quiz.guess(guess);
                    populate();
                }
            }
            ;


            function showProgress() {
                var currentQuestionNumber = quiz.questionIndex + 1;
                var element = document.getElementById("progress");
                element.innerHTML = "Question " + currentQuestionNumber + " of " + quiz.questions.length;
            }
            ;

            function showScores() {
                var gameOverHTML = "<h1>Result</h1>";
                gameOverHTML += "<h2 id='score'> Has acertado: " + quiz.score + "</h2>";
//                gameOverHTML +="<a href='enviandoQuizPuntaje.jsp'>Ir al menu principal</a>";
                gameOverHTML += "<input type='button' value='test'>";
                var element = document.getElementById("quiz");
                element.innerHTML = gameOverHTML;
                guess("btn" + 1, 0);

            }
            //Backup in case we want more than 5 quizes;
//            ResultSet rs = st.executeQuery("select * from preguntas_quiz");
//               ResultSetMetaData rsmd = rs.getMetaData();
//               int preguntas = rsmd.getColumnCount();
//               preguntas = preguntas-1;
//               int i;

// create questions
            var questions = [
            <%
               ResultSet rs;
               rs = st.executeQuery("select * from preguntas_quiz where quiz = '"+session.getAttribute("quiz")+"'");
               rs.next();
               int i;
               session.removeAttribute("quiz");
               for(i=1;i<=5;i++){%>
                   new Question("<%out.print(rs.getString("pregunta"+i));%>",["<%out.print(rs.getString("respuesta"+i+"_1"));%>","<%out.print(rs.getString("respuesta"+i+"_2"));%>","<%out.print(rs.getString("respuesta"+i+"_3"));%>","<%out.print(rs.getString("respuesta"+i+"_4"));%>"],"<%out.print(rs.getString("correcta"+i));%>"),
              <% }
            %>
            ];

            function Quiz(questions) {
                this.score = 0;
                this.questions = questions;
                this.questionIndex = 0;
            }

            Quiz.prototype.getQuestionIndex = function () {
                return this.questions[this.questionIndex];
            }

            Quiz.prototype.guess = function (answer) {
                if (this.getQuestionIndex().isCorrectAnswer(answer)) {
                    this.score++;
                }

                this.questionIndex++;
            }

            Quiz.prototype.isEnded = function () {
                return this.questionIndex === this.questions.length;
            }

            function Question(text, choices, answer) {
                this.text = text;
                this.choices = choices;
                this.answer = answer;
            }

            Question.prototype.isCorrectAnswer = function (choice) {
                return this.answer === choice;
            }

            var quiz = new Quiz(questions);
        </script>
    </head>
    <body><div class="contenedor-form">
            <div class="grid">


                <div id="quiz">
                    <h1>Quiz</h1>
                    <hr style="margin-bottom: 20px">

                    <p id="question"></p>
                    <!-- botones de opciones respuesta -->
                    <div class="buttons">
                        <button id="btn0"><span id="choice0"></span></button>
                        <button id="btn1"><span id="choice1"></span></button>
                        <button id="btn2"><span id="choice2"></span></button>
                        <button id="btn3"><span id="choice3"></span></button>
                    </div>

                    <hr style="margin-top: 50px">
                    <footer>
                        <p id="progress">Question x of y</p>
                    </footer>
                </div>
            </div>
        </div> 
        <script> populate();</script>
    </body>
</html>