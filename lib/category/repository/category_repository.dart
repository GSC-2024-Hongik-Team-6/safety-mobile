import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/category/model/category_detail_model.dart';
import 'package:safetyedu/category/model/category_model.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_list_meta.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/repository/model_list_repository_interface.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepository(),
);

class CategoryRepository implements IModelListRepository<CategoryModel> {
  final List<CategoryModel> items = [
    const CategoryModel(
      id: "1",
      title: 'Earthquake',
      description: 'What should we do when Earthquake happens?',
      imageUrl: 'images/earthquake.png',
      solvedQuizCount: 5,
      totalQuizCount: 20,
      categoryDescription: 'This is Earthquake category.',
    ),
    const CategoryModel(
      id: "2",
      title: 'Tsunami',
      description: 'What should we do when Tsunami comes?',
      imageUrl: 'images/tsunami.png',
      solvedQuizCount: 5,
      totalQuizCount: 20,
      categoryDescription: 'This is Tsunami category.',
    ),
  ];

  @override
  Future<ModelList<CategoryModel>> fetch() async {
    // TODO: implement fetch
    // 현재는 0.5초 후 더미 데이터 반환

    final meta = ModelListMeta(count: items.length);

    return Future.delayed(
      const Duration(milliseconds: 500),
      () => ModelList(
        items: items,
        meta: meta,
      ),
    );
  }

  Future<CategoryDetailModel> getCategoryDetail({required Id id}) {
    final category = items.firstWhere((element) => element.id == id);

    return Future.delayed(
      const Duration(milliseconds: 500),
      () => CategoryDetailModel(
        id: category.id,
        title: category.title,
        description: category.description,
        imageUrl: category.imageUrl,
        solvedQuizCount: category.solvedQuizCount,
        totalQuizCount: category.totalQuizCount,
        categoryDescription: category.categoryDescription,
        detail: 'This is detail of ${category.title}',
        quizzes: const [],
      ),
    );
  }
}
