import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:safetyedu/category/model/category_model.dart';
import 'package:safetyedu/quiz/model/quiz_model.dart';

part 'category_detail_model.g.dart';

@JsonSerializable()
class CategoryDetailModel extends CategoryModel {
  final String detail;
  final List<QuizItemModel> quizzes;

  const CategoryDetailModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.solvedQuizCount,
    required super.totalQuizCount,
    required this.detail,
    required this.quizzes,
  });

  factory CategoryDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryDetailModelFromJson(json);
}
