import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/quiz/component/option_card.dart';
import 'package:safetyedu/quiz/model/quiz_model.dart';

/// 객관식 퀴즈 뷰
class MultipleChoiceView extends StatelessWidget {
  final QuizItemMultipleChoice quiz;

  const MultipleChoiceView({
    super.key,
    required this.quiz,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          HtmlWidget(
            quiz.description,
            textStyle: TextStyles.titleTextStyle.copyWith(
              fontSize: 28.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: _OptionListView(
              options: quiz.options,
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionListView extends StatefulWidget {
  final List<QuizOption> options;

  const _OptionListView({
    required this.options,
  });

  @override
  State<_OptionListView> createState() => _OptionListViewState();
}

class _OptionListViewState extends State<_OptionListView> {
  int? currentUserSelection;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final option = widget.options[index];

        final isSelected = currentUserSelection == option.number;

        return GestureDetector(
          onTap: () {
            setState(() {
              currentUserSelection == option.number
                  ? currentUserSelection = null
                  : currentUserSelection = option.number;
            });
          },
          child: OptionCard(
            imageUrl: option.imageUrl,
            description: option.description,
            isSelected: isSelected,
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemCount: widget.options.length,
    );
  }
}
