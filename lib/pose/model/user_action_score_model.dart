import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:safetyedu/common/model/model_with_id.dart';

part 'user_action_score_model.freezed.dart';

@freezed
sealed class ActionScoreState with _$ActionScoreState implements IModelWithId {
  const factory ActionScoreState.uploading({
    required Id id,
    required double progress,
  }) = _Uploading;

  const factory ActionScoreState.submitted({
    required Id id,
    required double score,
  }) = _ActionScoreModel;

  const factory ActionScoreState.error({
    required Id id,
    required String message,
  }) = _Error;

  const factory ActionScoreState.uploaded({
    required Id id,
  }) = _Uploaded;
}
