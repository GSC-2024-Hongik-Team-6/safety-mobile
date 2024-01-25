import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_list_meta.freezed.dart';
part 'model_list_meta.g.dart';

@freezed
class ModelListMeta with _$ModelListMeta {
  const factory ModelListMeta({
    /// 아이템 개수
    required int count,
  }) = _ModelListMeta;

  factory ModelListMeta.fromJson(Map<String, dynamic> json) =>
      _$ModelListMetaFromJson(json);
}
