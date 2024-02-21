import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/education/model/education_model.dart';
import 'package:safetyedu/education/repository/education_repository.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:collection/collection.dart';
import 'package:safetyedu/common/provider/model_list_provider.dart';

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

    return EducationStateNotifier(
      repository: educationRepository,
    );
  },
);

class EducationStateNotifier
    extends DetailProvider<EducationModel, EducationRepository> {
  EducationStateNotifier({required super.repository});
}
