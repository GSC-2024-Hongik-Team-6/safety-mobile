import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_list_meta.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/provider/model_list_provider.dart';
import 'package:safetyedu/education/model/education_detail_model.dart';
import 'package:safetyedu/education/provider/education_provider.dart';
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

/// eid를 받고, 해당하는 EducationDetailModel의 quizzes를 반환
final quizListProvider =
    Provider.family<List<QuizStatusModel>?, Id>((ref, eid) {
  final educationDetail = ref.watch(educationDetailProvider(eid));

  if (educationDetail is! EducationDetailModel) return null;
  return educationDetail.quizzes;
});

final quizProvider = StateNotifierProvider<QuizStateNotifier, ModelListState>(
  (ref) => QuizStateNotifier(
    repository: ref.watch(quizRepositoryProvider),
  ),
);

class QuizStateNotifier
    extends DetailProvider<QuizStatusModel, QuizRepository> {
  QuizStateNotifier({required super.repository});

  @override
  Future<void> fetch({bool forceRefetch = false}) async {
    if (state is ModelList && !forceRefetch) {
      return;
    }

    const meta = ModelListMeta(count: 0);

    state = ModelList(data: <QuizStatusModel>[], meta: meta);
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
