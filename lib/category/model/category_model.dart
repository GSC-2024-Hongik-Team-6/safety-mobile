import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:safetyedu/common/model/model_with_id.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
class CategoryModel with _$CategoryModel implements ModelWithId {
  const factory CategoryModel({
    // 카테고리 id
    required Id id,

    // 카테고리 제목
    required String title,

    // 카테고리 설명
    required String description,

    // 카테고리 이미지
    required String image,

    // 사용자가 푼 퀴즈 수
    required int solvedQuizCount,

    // 카테고리 내 전체 퀴즈 수
    required int totalQuizCount,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
