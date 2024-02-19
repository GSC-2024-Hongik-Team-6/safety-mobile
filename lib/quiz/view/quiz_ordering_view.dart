import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/quiz/component/option_card.dart';
import 'package:safetyedu/quiz/model/quiz_model.dart';
import 'package:safetyedu/quiz/provider/current_selection_provider.dart';

/// 순서 맞추기 퀴즈 뷰
class OrderingView extends ConsumerStatefulWidget {
  final QuizItemOrdering quiz;
  final Id id;
  final Function(bool) onAnswered;

  const OrderingView({
    super.key,
    required this.quiz,
    required this.id,
    required this.onAnswered,
  });

  @override
  ConsumerState<OrderingView> createState() => _OrderingViewState();
}

class _OrderingViewState extends ConsumerState<OrderingView> {
  final List<QuizOption> _userSelections = [];
  late final List<QuizOption> _mixedOptions;

  @override
  void initState() {
    super.initState();

    _mixedOptions = _mixOptions(widget.quiz.options);
  }

  void _addSelection(QuizOption option) {
    setState(() {
      _userSelections.add(option);
    });

    if (_userSelections.length == widget.quiz.options.length) {
      // _userSelections의 순서와 widget.quiz.options의 순서가 같은 지 비교
      final isCorrect = _userSelections.every((element) =>
          element.number ==
          widget.quiz.options[_userSelections.indexOf(element)].number);

      widget.onAnswered(isCorrect);
      ref.read(selectionProvider.notifier).select(quizId: widget.id, number: 0);
    }
  }

  void _removeSelection(QuizOption option) {
    setState(() {
      _userSelections.remove(option);
    });

    ref.read(selectionProvider.notifier).unselect(quizId: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              final userSelection = _userSelections.length > index
                  ? _userSelections[index]
                  : null;

              return GestureDetector(
                onTap: userSelection != null
                    ? () {
                        _removeSelection(userSelection);
                      }
                    : null,
                child: OptionCard(
                  imageUrl: null,
                  description: userSelection?.description ?? '',
                  isSelected: false,
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemCount: _mixedOptions.length,
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              final option = _mixedOptions[index];

              final isSelected = _userSelections.contains(option);

              return GestureDetector(
                onTap: isSelected
                    ? null
                    : () {
                        _addSelection(option);
                      },
                child: OptionCard(
                  description: isSelected ? '' : option.description,
                  imageUrl: option.imageUrl,
                  isSelected: false,
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemCount: _mixedOptions.length,
          ),
        ),
      ],
    );
  }

  /// 옵션을 섞어서 반환
  List<QuizOption> _mixOptions(List<QuizOption> options) {
    final mixedOptions = List<QuizOption>.from(options);

    mixedOptions.shuffle();

    return mixedOptions;
  }
}
