import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/education/model/education_model.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/provider/dio_provider.dart';
import 'package:safetyedu/common/repository/model_list_repository_interface.dart';

part 'education_repository.g.dart';

final educationRepositoryProvider = Provider<EducationRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return EducationRepository(dio);
  },
);

@RestApi(baseUrl: '/education')
abstract class EducationRepository
    implements IModelListRepository<EducationModel> {
  factory EducationRepository(Dio dio) = _EducationRepository;

  @override
  @GET('/')
  Future<ModelList<EducationModel>> fetch();
}
