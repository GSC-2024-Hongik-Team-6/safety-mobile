import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:safetyedu/common/model/model_with_id.dart';

part 'pose_status_model.freezed.dart';
part 'pose_status_model.g.dart';

@freezed
class PoseStatusModel with _$PoseStatusModel implements IModelWithId {
  const factory PoseStatusModel({
    required bool isSolved,
    required Id id,
  }) = _PoseStatusModel;

  factory PoseStatusModel.fromJson(Map<String, dynamic> json) =>
      _$PoseStatusModelFromJson(json);
}
