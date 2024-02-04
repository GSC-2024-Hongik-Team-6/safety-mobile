import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:safetyedu/common/model/model_with_id.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel implements IModelWithId {
  @override
  final Id id;

  // 카테고리 제목
  final String title;

  // 카테고리 설명
  final String description;

  // 카테고리 이미지
  final String imageUrl;

  // 사용자가 푼 퀴즈 수
  final int solvedQuizCount;

  // 카테고리 내 전체 퀴즈 수
  final int totalQuizCount;

  // 카테고리 설명
  final String categoryDescription;

  const CategoryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.solvedQuizCount,
    required this.totalQuizCount,
    required this.categoryDescription,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
