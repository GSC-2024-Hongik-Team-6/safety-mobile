import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:safetyedu/common/model/model_with_id.dart';

part 'current_selection.freezed.dart';

@freezed
class CurrentSelection with _$CurrentSelection {
  const factory CurrentSelection({
    required Id quizId,
    required int number,
  }) = _CurrentSelection;
}
