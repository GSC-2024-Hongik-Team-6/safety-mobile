import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/quiz/model/quiz_model.dart';
import 'package:safetyedu/quiz/model/quiz_status_model.dart';
import 'package:safetyedu/quiz/repository/quiz_repository.dart';

final quizDetailProvier = Provider.family<QuizDetailModel?, Id>((ref, quizId) {
  final state = ref.watch(quizProvider);

  if (state is! ModelList) {
    return null;
  }

  return state.data.firstWhereOrNull(
    (element) => element.id == quizId,
  );
});

/// educationId를 id로 받음
final quizProvider = StateNotifierProvider<QuizStateNotifier, ModelListState>(
  (ref) => QuizStateNotifier(
    repository: ref.watch(quizRepositoryProvider),
  ),
);

class QuizStateNotifier extends StateNotifier<ModelListState> {
  final QuizRepository repository;

  QuizStateNotifier({
    required this.repository,
  }) : super(ModelListLoading()) {
    fetch();
  }

  Future<void> fetch({
    Id? educationId,
  }) async {
    try {
      final modelList = await repository.fetch(educationId: educationId);

      state = modelList;
    } catch (e) {
      state = ModelListError(message: e.toString());
    }
  }

  Future<void> getDetail({
    required Id id,
  }) async {
    // 만약 데이터가 없다면 fetch()를 호출
    if (state is! ModelList) {
      await fetch();
    }

    // 그럼에도 데이터가 없다면 return
    if (state is! ModelList) {
      return;
    }

    final modelList = state as ModelList<QuizStatusModel>;

    final response = await repository.getDetail(id: id);

    if (modelList.data.where((element) => element.id == id).isEmpty) {
      modelList.data.add(response);
    }

    state = modelList.copyWith(
      data: modelList.data.map((e) => e.id == id ? response : e).toList(),
    );
  }
}
