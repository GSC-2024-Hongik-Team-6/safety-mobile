import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/quiz/model/quiz_model.dart';
import 'package:safetyedu/quiz/provider/current_selection_provider.dart';
import 'package:safetyedu/quiz/provider/quiz_provider.dart';
import 'package:safetyedu/quiz/view/quiz_multiple_choice_view.dart';

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
    final currentSelection = ref.watch(currentSelectionProvider(widget.qid));

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            HtmlWidget(
              quiz.data.description,
              textStyle: TextStyles.titleTextStyle.copyWith(
                fontSize: 28.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24.0),
            Expanded(child: buildQuizDetail(quiz: quiz)),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: currentSelection != null ? () {} : null,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQuizDetail({required QuizDetailModel quiz}) {
    switch (quiz.type) {
      case QuizType.order:
        return _OrderingView(quiz: quiz.data as QuizItemOrdering);
      case QuizType.multipleChoice:
        return MultipleChoiceView(
          quiz: quiz.data as QuizItemMultipleChoice,
          id: quiz.id,
        );
    }
  }
}

/// 순서 맞추기 퀴즈 뷰
class _OrderingView extends StatelessWidget {
  final QuizItemOrdering quiz;

  const _OrderingView({
    required this.quiz,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Ordering View'),
    );
  }
}
