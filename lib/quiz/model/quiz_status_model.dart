import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:safetyedu/common/model/model_with_id.dart';

part 'quiz_status_model.freezed.dart';
part 'quiz_status_model.g.dart';

@freezed
class QuizStatusModel with _$QuizStatusModel implements IModelWithId {
  const factory QuizStatusModel({
    required bool isSolved,
    required Id id,
  }) = _QuizStatusModel;

  factory QuizStatusModel.fromJson(Map<String, dynamic> json) =>
      _$QuizStatusModelFromJson(json);
}
