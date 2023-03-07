import 'package:flutter/material.dart';
import 'quiz_brain.dart';
// Step 2 - Import the rFlutter_Alert package here.
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    setState(() {
      // Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If so,
      // Step 4 Part A - show an alert using rFlutter_alert (remember to read the docs for the package!)
      // Step 4 Part B is in the quiz_brain.dart
      // Step 4 Part C - reset the questionNumber,
      // Step 4 Part D - empty out the scoreKeeper.
      // Step 5 - If we've not reached the end, ELSE do the answer checking steps below 👇

      // Idea: Use API for questions
      // https://opentdb.com/api.php?amount=10&category=9&difficulty=easy&type=boolean
      // or https://the-trivia-api.com/

      if (quizBrain.isFinished() == true) {
        //This is the code for the basic alert from the docs for rFlutter Alert:
        //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();

        // Reusable alert style
        var alertStyle = AlertStyle(
            animationType: AnimationType.fromTop,
            isCloseButton: false,
            isOverlayTapDismiss: false,
            descStyle: TextStyle(fontWeight: FontWeight.bold),
            descTextAlign: TextAlign.center,
            animationDuration: Duration(milliseconds: 400),
            alertBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                color: Colors.black,
              ),
            ),
            titleStyle: TextStyle(
              color: Colors.green,
            ),
            constraints: BoxConstraints.expand(width: 300),
            //First to chars "55" represents transparency of color
            overlayColor: Color(0x55000000),
            alertElevation: 0,
            alertAlignment: Alignment.topCenter);

        // Alert dialog using custom alert style
        Alert(
          context: context,
          style: alertStyle,
          type: AlertType.success,
          title: "Finished!",
          desc: "You\'ve reached the end of the quiz. Well Done :)",
          buttons: [
            DialogButton(
              child: Text(
                "RESTART!",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.blue,
              radius: BorderRadius.circular(2.0),
            ),
          ],
        ).show();

        //Step 4 Part C - reset the questionNumber,
        quizBrain.reset();

        //Step 4 Part D - empty out the scoreKeeper.
        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          print('user got it right!');
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          print('user got it wrong');
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  int questionNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                checkAnswer(true);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green, // Background Color
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                checkAnswer(false);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red, // Background Color
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
