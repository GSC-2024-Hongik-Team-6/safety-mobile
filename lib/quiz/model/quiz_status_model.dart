import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:safetyedu/common/model/model_with_id.dart';

part 'quiz_status_model.g.dart';

/// 정답의 상태
///
/// [AnswerStatus.none] : 아직 풀지 않은 경우
/// [AnswerStatus.correct] : 풀고 정답인 경우
/// [AnswerStatus.wrong] : 풀었는데 틀린 경우
enum AnswerStatus {
  @JsonValue(0)
  none,

  @JsonValue(1)
  correct,

  @JsonValue(2)
  wrong,
}

extension AnswerStatusExtension on int {
  AnswerStatus toAnswerStatus() {
    switch (this) {
      case 0:
        return AnswerStatus.none;
      case 1:
        return AnswerStatus.correct;
      case 2:
        return AnswerStatus.wrong;
      default:
        throw ArgumentError.value(this, 'value', 'Invalid AnswerStatus value');
    }
  }
}

@JsonSerializable()
class QuizStatusModel implements IModelWithId {
//   const factory QuizStatusModel({
//     required AnswerStatus answerStatus,
//     required Id id,
//   }) = _QuizStatusModel;

//   factory QuizStatusModel.fromJson(Map<String, dynamic> json) =>
//       _$QuizStatusModelFromJson(json);
//
  @override
  final Id id;

  @JsonKey(name: 'isSolved')
  final AnswerStatus answerStatus;

  QuizStatusModel({
    required this.answerStatus,
    required this.id,
  });

  factory QuizStatusModel.fromJson(Map<String, dynamic> json) =>
      _$QuizStatusModelFromJson(json);

  QuizStatusModel copyWith({
    Id? id,
    AnswerStatus? answerStatus,
  }) {
    return QuizStatusModel(
      id: id ?? this.id,
      answerStatus: answerStatus ?? this.answerStatus,
    );
  }
}
