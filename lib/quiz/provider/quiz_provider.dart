import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/provider/model_list_provider.dart';
import 'package:safetyedu/quiz/model/quiz_model.dart';
import 'package:safetyedu/quiz/repository/quiz_repository.dart';

final quizDetailProvier = Provider.family<QuizDetailModel?, Id>((ref, Id id) {
  final state = ref.watch(quizProvider);

  if (state is! ModelList) {
    return null;
  }

  return state.data.firstWhereOrNull((element) => element.id == id);
});

final quizProvider = StateNotifierProvider<QuizStateNotifier, ModelListState>(
  (ref) => QuizStateNotifier(
    repository: ref.watch(quizRepositoryProvider),
  ),
);

class QuizStateNotifier
    extends DetailProvider<QuizDetailModel, QuizRepository> {
  QuizStateNotifier({required super.repository});
}
