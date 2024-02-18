import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_list_meta.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/quiz/model/quiz_model.dart';
import 'package:safetyedu/quiz/model/quiz_status_model.dart';
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

class QuizStateNotifier extends StateNotifier<ModelListState> {
  final QuizRepository repository;

  QuizStateNotifier({
    required this.repository,
  }) : super(ModelListLoading()) {
    fetch();
  }

  Future<void> fetch() async {
    const meta = ModelListMeta(count: 0);

    state = ModelList(data: <QuizStatusModel>[], meta: meta);
  }

  Future<void> getDetail({
    required Id id,
  }) async {
    if (state is! ModelList) {
      await fetch();
    }

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

  Future<void> answer({
    required Id id,
    required bool isCorrect,
  }) async {
    if (state is! ModelList) {
      await fetch();
    }

    if (state is! ModelList) {
      return;
    }

    final modelList = state as ModelList<QuizStatusModel>;

    final QuizDetailModel? quiz = modelList.data
        .firstWhereOrNull((element) => element.id == id) as QuizDetailModel?;

    if (quiz == null) {
      return;
    }

    final status = isCorrect ? AnswerStatus.correct : AnswerStatus.wrong;

    final updated = QuizDetailModel(
      type: quiz.type,
      data: quiz.data,
      id: quiz.id,
      answerStatus: status,
    );

    state = modelList.copyWith(
      data: modelList.data.map((e) => e.id == id ? updated : e).toList(),
    );

    // final userAnswer = UserAnswerModel(
    //   isCorrect: isCorrect,
    //   id: id,
    // );

    // await repository.submit(id: id, userAnswer: userAnswer);
  }
}
