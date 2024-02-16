import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/education/model/education_detail_model.dart';
import 'package:safetyedu/education/model/education_model.dart';
import 'package:safetyedu/education/repository/education_repository.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:collection/collection.dart';
import 'package:safetyedu/common/provider/model_list_provider.dart';
import 'package:safetyedu/quiz/repository/quiz_repository.dart';

final educationDetailProvider =
    Provider.family<EducationModel?, Id>((ref, Id id) {
  final state = ref.watch(educationProvider);

  if (state is! ModelList) {
    return null;
  }

  return state.data.firstWhereOrNull((element) => element.id == id);
});

final educationProvider =
    StateNotifierProvider<EducationStateNotifier, ModelListState>(
  (ref) {
    final educationRepository = ref.watch(educationRepositoryProvider);
    final quizRepository = ref.watch(quizRepositoryProvider);

    return EducationStateNotifier(
      repository: educationRepository,
      quizRepository: quizRepository,
    );
  },
);

class EducationStateNotifier
    extends DetailProvider<EducationModel, EducationRepository> {
  final QuizRepository quizRepository;

  EducationStateNotifier({
    required super.repository,
    required this.quizRepository,
  });

  @override
  Future<void> getDetail({required Id id}) async {
    if (state is! ModelList) {
      await fetch();
    }

    if (state is! ModelList) {
      return;
    }

    final modelList = state as ModelList<EducationModel>;

    final education =
        modelList.data.firstWhereOrNull((element) => element.id == id);

    if (education == null) {
      return;
    }

    final quizzes = await quizRepository.fetch(educationId: id);

    final detail = EducationDetailModel(
      id: education.id,
      title: education.title,
      description: education.description,
      thumbUrl: education.thumbUrl,
      detail: education.detail,
      images: education.images,
      quizzes: quizzes.data,
    );

    state = modelList.copyWith(
      data: modelList.data.map((e) => e.id == id ? detail : e).toList(),
    );
  }
}
