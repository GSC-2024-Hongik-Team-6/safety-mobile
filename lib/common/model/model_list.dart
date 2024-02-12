import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:safetyedu/common/model/model_list_meta.dart';

part 'model_list.g.dart';

/// ModelListState Base class
sealed class ModelListState {}

@JsonSerializable(genericArgumentFactories: true)
class ModelList<T> extends ModelListState {
  final List<T> data;
  final ModelListMeta meta;

  ModelList({
    required this.data,
    required this.meta,
  });

  /// copyWith
  ModelList<T> copyWith({
    List<T>? data,
    ModelListMeta? meta,
  }) {
    return ModelList<T>(
      data: data ?? this.data,
      meta: meta ?? this.meta,
    );
  }

  factory ModelList.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ModelListFromJson(json, fromJsonT);
}

/// 불러오는 데 에러가 생긴 상황
class ModelListError extends ModelListState {
  final String message;

  ModelListError({
    required this.message,
  });
}

/// 모델들을 불러오는 중인 상황
class ModelListLoading extends ModelListState {}

/// 새로고침 or 재요청 시
/// 이때 이미 데이터가 들어있다고 가정함
class ModelListRefetching<T> extends ModelList<T> {
  ModelListRefetching({
    required super.data,
    required super.meta,
  });
}
