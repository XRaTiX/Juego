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
    gameOverHTML += "<h2 id='score'> Has acertado: " + quiz.score + "</h2>";
	gameOverHTML +="<a href='funciona.html'>SIGUIENTE</a>";
    var element = document.getElementById("quiz");
    element.innerHTML = gameOverHTML;
    guess("btn"+1,0)
    
};

// create questions
var questions = [
    new Question("¿cuantos Roles posee XP?", ["3", "8","4", "7"], "4"),
    new Question("elementos que menciona XP referentes a la codificacion", ["clientes siempre presente", "notacion actualizada","estandares vitales", "dinamica presente"], "clientes siempre presente"),
    new Question("XP Estimula el uso de tarjetas", ["que aumenten la capacidad","CRC como mecanismo eficaz","CRC como memoria rapida","como mecanismo para incrementar la velocidad"], "CRC como mecanismo eficaz"),
    new Question("Correcion de todas las herramientas", ["complejo y difisil", "antes de que terminen","cuando todas esten echas", "antes de añadir nuevas funcionalidades"], "antes de añadir nuevas funcionalidades"),
    new Question("cuantos siclos posee XP", ["9", "7","4", "5"], "7")
];

// create quiz
var quiz = new Quiz(questions);

// display quiz
populate();


