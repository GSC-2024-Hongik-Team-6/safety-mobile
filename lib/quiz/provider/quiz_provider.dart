import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/quiz/model/quiz_model.dart';
import 'package:safetyedu/quiz/repository/quiz_repository.dart';

final quizDetailProvier = Provider.family<QuizDetailModel?, Id>((ref, Id id) {
  final state = ref.watch(quizProvider);

  if (state is! ModelList) {
    return null;
  }

  return state.items.firstWhereOrNull((element) => element.id == id);
});

final quizProvider = StateNotifierProvider<QuizStateNotifier, ModelListState>(
  (ref) => QuizStateNotifier(
    repository: ref.watch(quizRepositoryProvider),
  ),
);

class QuizStateNotifier extends StateNotifier<ModelListState> {
  final QuizRepository repository;

  QuizStateNotifier({
    required this.repository,
  }) : super(ModelListLoading());

  Future<void> getDetail({
    required Id id,
  }) async {
    final modelList = state as ModelList<QuizDetailModel>;

    final response = await repository.getDetail(id: id);

    if (modelList.items.where((element) => element.id == id).isEmpty) {
      modelList.items.add(response);
    }

    state = modelList.copyWith(
      items: modelList.items.map((e) => e.id == id ? response : e).toList(),
    );
  }
}
