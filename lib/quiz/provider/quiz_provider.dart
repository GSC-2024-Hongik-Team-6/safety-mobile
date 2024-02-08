import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/quiz/model/quiz_model.dart';
import 'package:safetyedu/quiz/repository/quiz_repository.dart';

class QuizStateNotifier extends StateNotifier<QuizState> {
  final QuizRepository quizRepository;

  QuizStateNotifier({
    required this.quizRepository,
  }) : super(QuizLoading());

  Future<void> getDetail({
    required Id id,
  }) async {
    state = QuizLoading();

    try {
      final quiz = await quizRepository.getDetail(id: id);

      state = quiz;
    } catch (e) {
      state = QuizError(message: e.toString());
    }
  }
}
