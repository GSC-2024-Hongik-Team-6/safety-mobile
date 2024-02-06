import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/category/model/category_detail_model.dart';
import 'package:safetyedu/category/model/category_model.dart';

import 'package:safetyedu/category/repository/category_repository.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:collection/collection.dart';

final categoryDetailProvider =
    Provider.family<CategoryModel?, Id>((ref, Id id) {
  final state = ref.watch(categoryProvider);

  if (state is! ModelList) {
    return null;
  }

  return state.items.firstWhereOrNull((element) => element.id == id);
});

final categoryProvider =
    StateNotifierProvider<CategoryStateNotifier, ModelListState>(
  (ref) => CategoryStateNotifier(
    repository: ref.watch(categoryRepositoryProvider),
  ),
);

class CategoryStateNotifier extends StateNotifier<ModelListState> {
  /// [IModelListRepository]로 DI해도 상관 없음
  final CategoryRepository repository;

  CategoryStateNotifier({
    required this.repository,
  }) : super(ModelListLoading()) {
    fetch();
  }

  Future<void> fetch() async {
    state = ModelListLoading();

    try {
      final modelList = await repository.fetch();

      state = modelList;
    } catch (e) {
      state = ModelListError(message: e.toString());
    }
  }

  Future<void> getDetail({
    required Id id,
  }) async {
    // 만약 데이터가 없다면 fetch()를 호출
    if (state is! ModelList) {
      await fetch();
    }

    // 그럼에도 데이터가 없다면 return
    if (state is! ModelList) {
      return;
    }

    final modelList = state as ModelList<CategoryModel>;

    final response = await repository.getCategoryDetail(id: id);

    if (modelList.items.where((element) => element.id == id).isEmpty) {
      modelList.items.add(response);
    }

    state = modelList.copyWith(
      items: modelList.items.map((e) => e.id == id ? response : e).toList(),
    );
  }
}
