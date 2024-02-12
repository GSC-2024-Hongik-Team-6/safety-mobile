import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:safetyedu/education/model/education_model.dart';
import 'package:safetyedu/quiz/model/quiz_status_model.dart';

part 'education_detail_model.g.dart';

/// ### 카테고리 상세 모델
///
/// 예시 JSON 데이터:
/// ```json
/// {
///   "id": "1",
///   "title": "Earthquake",
///   "description": "What should we do when Earthquake happens?",
///   "imageUrl": "images/earthquake.png",
///   "detail": "This is detail of Earthquake",
///   "quizzes": [
///     {
///       "isSolved": false,
///       "id": "0"
///     },
///     {
///       "isSolved": false,
///       "id": "1"
///     }
///   ]
/// }
/// ```
@JsonSerializable()
class EducationDetailModel extends EducationModel {
  final List<QuizStatusModel> quizzes;

  const EducationDetailModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.detail,
    required this.quizzes,
  });

  factory EducationDetailModel.fromJson(Map<String, dynamic> json) =>
      _$EducationDetailModelFromJson(json);
}
