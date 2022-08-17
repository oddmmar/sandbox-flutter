import 'package:flutter/material.dart';
import 'package:section02/widgets/quiz.dart';
import 'package:section02/widgets/result.dart';

void main(List<String> args) => runApp(const Section02());

class Section02 extends StatefulWidget {
  const Section02({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _Section02State();
}

class _Section02State extends State<Section02> {
  final _questions = const [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1},
      ],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Rabbit', 'score': 3},
        {'text': 'Snake', 'score': 11},
        {'text': 'Elephant', 'score': 5},
        {'text': 'Lion', 'score': 9},
      ],
    },
    {
      'questionText': 'Who\'s your favorite fictional serial killer?',
      'answers': [
        {'text': 'Dexter Morgan', 'score': 1},
        {'text': 'Hannibal Lecter', 'score': 1},
        {'text': 'Joe Goldberg', 'score': 1},
        {'text': 'Norman Bates', 'score': 1},
      ],
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestions({int score = 0}) {
    _totalScore += score;
    setState(() {
      ++_questionIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Section Two',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Section Two'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(80, 10, 80, 0),
          child: Center(
            child: _questionIndex < _questions.length
                ? Quiz(
                    answerQuestion: _answerQuestions,
                    questionIndex: _questionIndex,
                    questions: _questions,
                  )
                : Result(
                    totalScore: _totalScore,
                    msgText: 'My Dude!',
                    resetHandler: _resetQuiz,
                  ),
          ),
        ),
      ),
    );
  }
}
