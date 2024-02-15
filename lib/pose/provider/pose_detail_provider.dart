import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/provider/model_list_provider.dart';
import 'package:safetyedu/pose/model/pose_model.dart';
import 'package:safetyedu/pose/repository/pose_repository.dart';

final poseDetailProvier = Provider.family<PoseDetailModel?, Id>((ref, Id id) {
  final state = ref.watch(poseProvider);

  if (state is! ModelList) {
    return null;
  }

  return state.data.firstWhereOrNull((element) => element.id == id);
});

final poseProvider = StateNotifierProvider<PoseStateNotifier, ModelListState>(
      (ref) => PoseStateNotifier(
    repository: ref.watch(PoseRepositoryProvider),
  ),
);

class PoseStateNotifier
    extends DetailProvider<PoseDetailModel, PoseRepository> {
  PoseStateNotifier({required super.repository});
}
