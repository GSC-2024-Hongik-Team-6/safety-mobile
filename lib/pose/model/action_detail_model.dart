import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:safetyedu/pose/model/action_model.dart';

part 'action_detail_model.g.dart';

@JsonSerializable()
class ActionDetailModel extends ActionModel {
  final String detail;
  final String videoUrl;

  const ActionDetailModel({
    required super.id,
    required super.title,
    required super.description,
    required super.thumbUrl,
    required this.detail,
    required this.videoUrl,
  });

  factory ActionDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ActionDetailModelFromJson(json);
}
