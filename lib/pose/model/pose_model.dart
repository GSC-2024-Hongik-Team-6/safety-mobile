import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:safetyedu/common/model/model_with_id.dart';

part 'pose_model.freezed.dart';
part 'pose_model.g.dart';

enum PoseType {
  @JsonValue('MULTIPLE_CHOICE')
  multipleChoice,

  @JsonValue('ORDERING')
  order,
}

/// ### 퀴즈 모델
///
/// - [id] 퀴즈의 ID
/// - [type] 퀴즈의 타입
///   - [PoseType.multipleChoice] 객관식 퀴즈
///   - [PoseType.order] 순서 맞추기 퀴즈
/// - [item] 퀴즈의 내용
///
/// 예시:
/// ```json
/// {
///   "id": 1,
///   "type": "MULTIPLE_CHOICE", // "ORDERING" or "MULTIPLE_CHOICE"
///   "item": {
///     "description": "지진 대피소 표시로 올바른 것을 고르세요",
///     "answer": 1,
///     "options": [
///       {
///         "id": "0",
///         "description": "지진 대피소 표시 1"
///       },
///       {
///         "id": "1",
///         "description": "지진 대피소 표시 2",
///         "imageUrl": "images/2.jpg"
///       },
///       {
///         "id": "2",
///         "description": "지진 대피소 표시 3",
///         "imageUrl": "images/3.jpg"
///       },
///       {
///         "id": "3",
///         "description": "지진 대피소 표시 4",
///         "imageUrl": "images/4.jpg"
///       }
///     ]
///   }
/// }
/// ```
@freezed
class PoseDetailModel with _$PoseDetailModel implements IModelWithId {
  const factory PoseDetailModel({
    required Id id,
    required PoseType type,
    required PoseItemModel data,
  }) = _PoseDetailModel;

  factory PoseDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PoseDetailModelFromJson(json);
}

/// 퀴즈 아이템 모델
///
/// [PoseItemModel.ordering]과 [PoseItemModel.multipleChoice] 두 가지가 존재함
@freezed
class PoseItemModel with _$PoseItemModel {
  /// 순서 맞추기 퀴즈 타입\
  /// 이때 options.id가 그대로 순서가 된다
  ///
  /// `answer` 필드가 없음
  ///
  /// 예시:
  /// ```json
  /// {
  ///   "description": "지진 대피소 표시로 올바른 것을 고르세요",
  ///   "options": [
  ///     {
  ///       "id": 1,
  ///       "description": "지진 대피소 표시 1"
  ///     },
  ///     {
  ///       "id": 2,
  ///       "description": "지진 대피소 표시 2",
  ///       "imageUrl": "images/2.jpg"
  ///     },
  ///     {
  ///       "id": 3,
  ///       "description": "지진 대피소 표시 3",
  ///       "imageUrl": "images/3.jpg"
  ///     },
  ///     {
  ///       "id": 4,
  ///       "description": "지진 대피소 표시 4",
  ///       "imageUrl": "images/4.jpg"
  ///     }
  ///   ]
  /// }
  /// ```
  const factory PoseItemModel.ordering({
    required String description,
    required List<PoseOption> options,
  }) = PoseItemOrdering;

  /// 객관식 퀴즈 타입
  ///
  /// 예시:
  /// ```json
  /// {
  ///   "description": "지진 대피소 표시로 올바른 것을 고르세요",
  ///   "answer": 1,
  ///   "options": [
  ///     {
  ///       "id": "0",
  ///       "description": "지진 대피소 표시 1"
  ///     },
  ///     {
  ///       "id": "1",
  ///       "description": "지진 대피소 표시 2",
  ///       "imageUrl": "images/2.jpg"
  ///     },
  ///     {
  ///       "id": "2",
  ///       "description": "지진 대피소 표시 3",
  ///       "imageUrl": "images/3.jpg"
  ///     },
  ///     {
  ///       "id": "3",
  ///       "description": "지진 대피소 표시 4",
  ///       "imageUrl": "images/4.jpg"
  ///     }
  ///   ]
  /// }
  /// ```
  const factory PoseItemModel.multipleChoice({
    required String description,
    required List<PoseOption> options,
    required int answer,
  }) = PoseItemMultipleChoice;

  factory PoseItemModel.fromJson(Map<String, dynamic> json) =>
      _$PoseItemModelFromJson(json);
}

/// 퀴즈의 선택지
///
/// - [id] 선택지 id는 `int`여야 함
///   - 만약 [ORDERING] 타입의 퀴즈라면, id의 순서가 정답이 됨
/// - [description] 퀴즈 설명
/// - [imageUrl] 퀴즈 이미지
///
/// **둘 중 하나는 있어야 함**
@freezed
class PoseOption with _$PoseOption {
  const factory PoseOption({
    required int number,
    String? description,
    String? imageUrl,
  }) = _PoseOption;

  factory PoseOption.fromJson(Map<String, dynamic> json) =>
      _$PoseOptionFromJson(json);
}
