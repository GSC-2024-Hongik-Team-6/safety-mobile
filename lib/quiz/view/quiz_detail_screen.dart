import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:safetyedu/common/component/custom_elevated_button.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/provider/router_provider.dart';
import 'package:safetyedu/education/model/education_detail_model.dart';
import 'package:safetyedu/education/provider/education_provider.dart';
import 'package:safetyedu/quiz/model/current_selection.dart';
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
  late final Id? _nextQuizId;
  bool _isCorrect = false;
  bool _isSubmitted = false;

  @override
  void initState() {
    super.initState();

    ref.read(quizProvider.notifier).getDetail(id: widget.qid);

    _nextQuizId = _getNextQuizId();
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HtmlWidget(
              quiz.data.description,
              textStyle: TextStyles.titleTextStyle.copyWith(
                fontSize: 28.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24.0),
            Expanded(
                child: _buildQuizDetail(
                    quiz: quiz,
                    onAnswered: (isCorrect) {
                      setState(() {
                        _isCorrect = isCorrect;
                      });
                    })),
            const SizedBox(height: 24.0),
            _buildButton(
              nextQuizId: _nextQuizId,
              currentSelection: currentSelection,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizDetail({
    required QuizDetailModel quiz,
    required Function(bool) onAnswered,
  }) {
    switch (quiz.type) {
      case QuizType.order:
        return _OrderingView(quiz: quiz.data as QuizItemOrdering);
      case QuizType.multipleChoice:
        return MultipleChoiceView(
          quiz: quiz.data as QuizItemMultipleChoice,
          id: quiz.id,
          onAnswered: onAnswered,
        );
    }
  }

  Id _getCurrentEducationId() {
    final goRouter = ref.read(routerProvider);
    final currentLocation =
        goRouter.routerDelegate.currentConfiguration.uri.toString();
    // example: /education/1/quiz/1
    final uri = Uri.parse(currentLocation);
    final pathSegments = uri.pathSegments;

    final educationId = pathSegments[1].toId();

    return educationId;
  }

  Id? _getNextQuizId() {
    final currentEducationId = _getCurrentEducationId();
    final educationModel =
        ref.read(educationDetailProvider(currentEducationId));
    if (educationModel == null) {
      return null;
    }

    final educationDetail = educationModel as EducationDetailModel;

    final quizList = educationDetail.quizzes;

    final currentIndex =
        quizList.indexWhere((element) => element.id == widget.qid);

    final nextIndex = currentIndex + 1;

    if (nextIndex >= quizList.length) {
      return null;
    }

    return quizList[nextIndex].id;
  }

  Widget _buildButton({
    required Id? nextQuizId,
    required CurrentSelection? currentSelection,
  }) {
    // 만약 퀴즈가 제출되기 전이라면
    if (!_isSubmitted) {
      final isSelected = currentSelection != null;
      return _SubmitButton(
        isEnabled: isSelected,
        onPressed: () {
          ref.read(quizProvider.notifier).answer(
                id: widget.qid,
                isCorrect: _isCorrect,
              );
          setState(() {
            _isSubmitted = true;
          });
        },
      );
    }
    // 퀴즈가 제출되고, 다음 퀴즈로 넘어가기 버튼
    // 만약 지금이 마지막 퀴즈라면
    if (nextQuizId == null) {
      return const _NextQuestionButton(
        isEnabled: false,
        onPressed: null,
      );
    }
    // 다음 퀴즈로 넘어가기
    return _NextQuestionButton(
      isEnabled: true,
      onPressed: () {
        ref.read(routerProvider).goNamed(
          QuizDetailScreen.routeName,
          pathParameters: {
            'qid': nextQuizId.toString(),
          },
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback? onPressed;

  const _SubmitButton({
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedBotton(
      onPressed: isEnabled ? onPressed : null,
      text: 'Submit',
    );
  }
}

class _NextQuestionButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback? onPressed;

  const _NextQuestionButton({
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (isEnabled) {
      return CustomElevatedBotton(
        onPressed: onPressed,
        text: 'Next Question',
      );
    } else {
      return const CustomElevatedBotton(
        onPressed: null,
        text: 'This is the last question',
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
