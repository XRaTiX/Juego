function populate() {
    if(quiz.isEnded()) {
        showScores();
    }
    else {
        // show question
        var element = document.getElementById("question");
        element.innerHTML = quiz.getQuestionIndex().text;

        // show options
        var choices = quiz.getQuestionIndex().choices;
        for(var i = 0; i < choices.length; i++) {
            var element = document.getElementById("choice" + i);
            element.innerHTML = choices[i];
            guess("btn" + i, choices[i]);
        }

        showProgress();
    }
};

function guess(id, guess) {
    var button = document.getElementById(id);
    button.onclick = function() {
        quiz.guess(guess);
        populate();
    }
};


function showProgress() {
    var currentQuestionNumber = quiz.questionIndex + 1;
    var element = document.getElementById("progress");
    element.innerHTML = "Question " + currentQuestionNumber + " of " + quiz.questions.length;
};

function showScores() {
    var gameOverHTML = "<h1>Result</h1>";
    gameOverHTML += "<h2 id='score'> Your scores: " + quiz.score + "</h2>";
    var element = document.getElementById("quiz");
    element.innerHTML = gameOverHTML;
};

// create questions
var questions = [
    new Question("¿porque se concidera que la propiedad del codigo es compartido?", ["4", "h","todo el personal puede trabajar con cualquier parte del codigo", "t"], "todo el personal puede trabajar con cualquier parte del codigo"),
    new Question("¿que se gana y pierde por programar por progranar en pareja", ["IiI", "i","I", "mayor calidad de contenido; perdida de productividad"], "mayor calidad de contenido; perdida de productividad"),
	new Question("¿Como hacen los desarrolladores de XP para comprovar el correcto funcionamiento del codigo?", ["pruebas unitarias continuas y corrieguiendo errores antes de añadir funcionalidad", "KJ","P", "debugger"], "pruebas unitarias continuas y corrieguiendo errores antes de añadir funcionalidad"),
    new Question("Mientras mas simple sea el codigo, ¿que se necesitara hacer menos?", ["menor comunicacion", "opo","456", "hggdf"], "menor comunicacion"),
	new Question("¿Es el responsable del proseso global, y guia a los integrantes por el proceso correcto?", ["", "","Entrenador(coach)", ""], "Entrenador(coach)"),
    new Question("¿Es el encargado de seguimiento y de verificar el grado de acuerdo entre estimaciones realizadas y tiempo?", ["A", "B","C", "tracker"], "tracker"),
	new Question("¿Es el vinculo entre cliente y programador?", ["A", "Es el gestor","C", "V"], "Es el gestor"),
    new Question("Roles comunes con otras metodologias", ["", "","Programador, cliente, tester y consultador", ""], "Programador, cliente, tester y consultador"),
];

// create quiz
var quiz = new Quiz(questions);

// display quiz
populate();


