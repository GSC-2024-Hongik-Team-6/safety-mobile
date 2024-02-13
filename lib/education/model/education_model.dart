import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:safetyedu/common/model/model_with_id.dart';

part 'education_model.g.dart';

@JsonSerializable()
class EducationModel implements IModelWithId {
  @override
  final Id id;

  // 카테고리 제목
  final String title;

  // 카테고리 설명
  final String description;

  // 카테고리 이미지
  final String imageUrl;

  final String detail;

  const EducationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.detail,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) =>
      _$EducationModelFromJson(json);

  Map<String, dynamic> toJson() => _$EducationModelToJson(this);
}
