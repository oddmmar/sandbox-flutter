import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final String msgText;
  final int totalScore;
  final VoidCallback resetHandler;

  String get resultScore {
    String? resultText;

    if (totalScore <= 8) {
      resultText = 'You are awesome and innocent';
    } else if (totalScore <= 12) {
      resultText = 'You are pretty likeable';
    } else if (totalScore <= 16) {
      resultText = 'You are ... strange';
    } else {
      resultText = 'You are straight up bad!';
    }

    return ('$msgText \n $resultText');
  }

  const Result(
      {Key? key,
      required this.msgText,
      required this.totalScore,
      required this.resetHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultScore,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: resetHandler,
            child: const Text('Reset Quiz'),
          )
        ],
      ),
    );
  }
}
