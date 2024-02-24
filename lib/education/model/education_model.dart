import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:safetyedu/common/model/model_with_id.dart';

part 'education_model.g.dart';

@JsonSerializable()
class EducationModel implements IModelWithId {
  @override
  @JsonKey(name: 'educationId')
  final Id id;

  // 카테고리 제목
  @JsonKey(name: 'educationName')
  final String title;

  // 카테고리 설명
  @JsonKey(name: 'educationDescription')
  final String? description;

  // 카테고리 이미지
  final String? thumbUrl;

  // 카테고리 상세 내용
  @JsonKey(name: 'educationDetail')
  final String? detail;

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

  factory EducationModel.copyWith({
    required EducationModel model,
    Id? id,
    String? title,
    String? description,
    String? thumbUrl,
    String? detail,
    List<String>? images,
  }) {
    return EducationModel(
      id: id ?? model.id,
      title: title ?? model.title,
      description: description ?? model.description,
      thumbUrl: thumbUrl ?? model.thumbUrl,
      detail: detail ?? model.detail,
      images: images ?? model.images,
    );
  }
}
