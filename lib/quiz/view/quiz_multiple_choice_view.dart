import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/quiz/component/option_card.dart';
import 'package:safetyedu/quiz/model/quiz_model.dart';
import 'package:safetyedu/quiz/provider/current_selection_provider.dart';

/// 객관식 퀴즈 뷰
class MultipleChoiceView extends ConsumerWidget {
  final QuizItemMultipleChoice quiz;
  final Id id;
  final Function(bool) onAnswered;

  const MultipleChoiceView({
    super.key,
    required this.quiz,
    required this.id,
    required this.onAnswered,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSelection = ref.watch(currentSelectionProvider(id));

    final options = quiz.options;

    return ListView.separated(
      itemBuilder: (context, index) {
        final option = options[index];

        final isSelected = currentSelection?.number == option.number;

        return GestureDetector(
          onTap: () {
            ref.read(selectionProvider.notifier).select(
                  quizId: id,
                  number: option.number,
                );

            final isCorrect = option.number == quiz.answer;
            onAnswered(isCorrect);
          },
          child: OptionCard(
            imageUrl: option.imageUrl,
            description: option.description,
            isSelected: isSelected,
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemCount: options.length,
    );
  }
}
