import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:safetyedu/category/model/category_detail_model.dart';
import 'package:safetyedu/category/model/category_model.dart';
import 'package:safetyedu/common/const/data.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/provider/dio_provider.dart';
import 'package:safetyedu/common/repository/model_list_repository_interface.dart';

part 'category_repository.g.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return CategoryRepository(dio, baseUrl: '$apiurl/education');
  },
);

@RestApi()
abstract class CategoryRepository implements IDetailRepository<CategoryModel> {
  factory CategoryRepository(Dio dio, {String baseUrl}) = _CategoryRepository;

  @override
  @GET('/')
  Future<ModelList<CategoryModel>> fetch();

  @override
  @GET('/{id}')
  Future<CategoryDetailModel> getDetail({
    @Path() required Id id,
  });
}
