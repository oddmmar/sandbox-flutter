import 'package:flutter/material.dart';
import 'package:section02/widgets/question.dart';
import 'package:section02/widgets/answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function({int score}) answerQuestion;

  const Quiz(
      {Key? key,
      required this.questions,
      required this.answerQuestion,
      required this.questionIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Question(
          questionText: questions[questionIndex]['questionText'] as String,
        ),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          //spread operator!!
          return Answer(
            selectHandler: (() =>
                answerQuestion(score: answer['score'] as int)),
            answerText: answer['text'] as String,
          );
        }).toList()
      ],
    );
  }
}
