import 'package:flutter/material.dart';
import 'package:safetyedu/common/model/model_with_id.dart';

class QuizButton extends StatelessWidget {
  /// 퀴즈의 아이콘
  final IconData icon;

  /// 퀴즈의 ID
  final Id id;

  const QuizButton({
    super.key,
    required this.icon,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        print('QuizButton: $id Pressed');
      },
      icon: Icon(
        icon,
        size: 48.0,
      ),
    );
  }
}
