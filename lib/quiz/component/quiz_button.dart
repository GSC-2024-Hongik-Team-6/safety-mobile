import 'package:flutter/material.dart';
import 'package:safetyedu/quiz/model/quiz_status_model.dart';

class QuizCard extends StatelessWidget {
  final AnswerStatus answerStatus;

  const QuizCard({
    super.key,
    required this.answerStatus,
  });

  factory QuizCard.fromModel(QuizStatusModel model) {
    return QuizCard(
      answerStatus: model.answerStatus,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star,
      size: 48.0,
      color: _iconColor(),
    );
  }

  Color _iconColor() {
    return switch (answerStatus) {
      AnswerStatus.none => Colors.grey,
      AnswerStatus.correct => Colors.green,
      AnswerStatus.wrong => Colors.red,
    };
  }
}
