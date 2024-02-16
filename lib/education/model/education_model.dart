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
  final String thumbUrl;

  // 카테고리 상세 내용
  final String detail;

  /// detail 페이지에 표시할 이미지들(nullable)
  final List<String>? images;

  const EducationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbUrl,
    required this.detail,
    required this.images,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) =>
      _$EducationModelFromJson(json);

  Map<String, dynamic> toJson() => _$EducationModelToJson(this);
}
