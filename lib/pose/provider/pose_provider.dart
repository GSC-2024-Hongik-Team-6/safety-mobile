import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/provider/model_list_provider.dart';
import 'package:safetyedu/education/model/education_model.dart';
import 'package:safetyedu/pose/repository/action_repository.dart';

final poseDetailProvider = Provider.family<EducationModel?, Id>((ref, Id id) {
  final state = ref.watch(poseProvider);

  if (state is! ModelList) {
    return null;
  }

  return state.data.firstWhereOrNull((element) => element.id == id);
});

final poseProvider = StateNotifierProvider<PoseStateNotifier, ModelListState>(
  (ref) {
    final actionRepository = ref.watch(actionRepositoryProvider);

    return PoseStateNotifier(repository: actionRepository);
  },
);

class PoseStateNotifier
    extends DetailProvider<EducationModel, ActionRepository> {
  PoseStateNotifier({required super.repository});
}
