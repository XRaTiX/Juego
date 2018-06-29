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
    var element = document.getElementById("quiz");
    element.innerHTML = gameOverHTML;
    guess("btn"+1,0)
    
};

// create questions
var questions = [
    new Question("En que se diferencia la programacion extrema del resto?", ["experiencia", "indepencia","adaptivilidad", "previsibilidad"], "adaptivilidad"),
    new Question("Valores de XP", ["simplicidad, comunicacion y coraje", "B","C", "D"], "simplicidad, comunicacion y coraje"),
    new Question("Se realizan encuentros seguidos para conocer la opimion del cliente ¿esto es?", ["A", "B","C", "retro alimentacion"], "retro alimentacion"),
    new Question("¿Un diseño complejo del codigo seria visto como?", ["complejo y difisil", "B","C", "D"], "complejo y difisil"),
    new Question("¿que es visto como mas importante por usuarios de XP?", ["Resistencia a obstaculos", "adaptarse a cambios","determinacion a terminar", "originalidad"], "adaptarse a cambios")
];

// create quiz
var quiz = new Quiz(questions);

// display quiz
populate();