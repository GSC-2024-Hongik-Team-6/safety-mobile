import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_meta_model.g.dart';
part 'quiz_meta_model.freezed.dart';

enum QuizType {
  @JsonValue('MULTIPLE_CHOICE')
  multipleChoice,

  @JsonValue('ORDERING')
  order,
}

@freezed
class QuizMetaModel with _$QuizMetaModel {
  const factory QuizMetaModel({
    required QuizType type,
  }) = _QuizMetaModel;

  factory QuizMetaModel.fromJson(Map<String, dynamic> json) =>
      _$QuizMetaModelFromJson(json);
}
