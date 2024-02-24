import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/education/model/education_detail_model.dart';
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
    implements IDetailRepository<EducationModel> {
  factory EducationRepository(Dio dio) = _EducationRepository;

  @override
  @GET('')
  @Headers({'accessToken': 'true'})
  Future<ModelList<EducationModel>> fetch();

  @override
  @GET('/{id}')
  @Headers({'accessToken': 'true'})
  Future<EducationDetailModel> getDetail({
    @Path() required Id id,
  });
}
