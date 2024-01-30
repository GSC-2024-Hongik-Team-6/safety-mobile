// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:safetyedu/category/repository/category_repository.dart';
import 'package:safetyedu/common/model/model_list.dart';

final categoryListProvider =
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
}
