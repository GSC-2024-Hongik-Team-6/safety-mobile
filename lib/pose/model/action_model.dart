import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:safetyedu/common/model/model_with_id.dart';

part 'action_model.g.dart';

@JsonSerializable()
class ActionModel implements IModelWithId {
  @override
  final Id id;

  final String title;

  final String description;

  final String thumbUrl;

  const ActionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbUrl,
  });

  factory ActionModel.fromJson(Map<String, dynamic> json) =>
      _$ActionModelFromJson(json);
}
