import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:safetyedu/common/model/model_with_id.dart';

part 'user_answer_model.freezed.dart';
part 'user_answer_model.g.dart';

@freezed
class UserAnswerModel with _$UserAnswerModel {
  const factory UserAnswerModel({
    required Id id, // quiz id
    required bool isCorrect,
  }) = _UserAnswerModel;

  factory UserAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$UserAnswerModelFromJson(json);
}
