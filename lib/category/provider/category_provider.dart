import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/category/model/category_model.dart';
import 'package:safetyedu/category/repository/category_repository.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:collection/collection.dart';
import 'package:safetyedu/common/provider/model_list_provider.dart';

final categoryDetailProvider =
    Provider.family<CategoryModel?, Id>((ref, Id id) {
  final state = ref.watch(categoryProvider);

  if (state is! ModelList) {
    return null;
  }

  return state.data.firstWhereOrNull((element) => element.id == id);
});

final categoryProvider =
    StateNotifierProvider<CategoryStateNotifier, ModelListState>(
  (ref) => CategoryStateNotifier(
    repository: ref.watch(categoryRepositoryProvider),
  ),
);

class CategoryStateNotifier
    extends DetailProvider<CategoryModel, CategoryRepository> {
  CategoryStateNotifier({required super.repository});
}
