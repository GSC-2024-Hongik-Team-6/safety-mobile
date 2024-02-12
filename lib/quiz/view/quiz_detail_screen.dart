import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/quiz/provider/quiz_provider.dart';

class QuizDetailScreen extends ConsumerStatefulWidget {
  static const routeName = '/quiz-detail';

  final Id qid;

  const QuizDetailScreen({
    super.key,
    required this.qid,
  });

  @override
  ConsumerState<QuizDetailScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizDetailScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(quizProvider.notifier).getDetail(id: widget.qid);
  }

  @override
  Widget build(BuildContext context) {
    final quiz = ref.watch(quizDetailProvier(widget.qid));

    if (quiz == null) {
      return const DefaultLayout(
        title: 'Loading',
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      title: 'Quiz Detail Page ${widget.qid}',
      child: Center(
        child: Text(
          quiz.item.description,
        ),
      ),
    );
  }
}
