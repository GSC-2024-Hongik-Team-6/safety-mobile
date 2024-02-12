import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:safetyedu/education/model/education_detail_model.dart';
import 'package:safetyedu/education/model/education_model.dart';
import 'package:safetyedu/common/const/data.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/provider/dio_provider.dart';
import 'package:safetyedu/common/repository/model_list_repository_interface.dart';

part 'education_repository.g.dart';

final educationRepositoryProvider = Provider<EducationRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return EducationRepository(dio, baseUrl: '$apiurl/education');
  },
);

@RestApi()
abstract class EducationRepository
    implements IDetailRepository<EducationModel> {
  factory EducationRepository(Dio dio, {String baseUrl}) = _EducationRepository;

  @override
  @GET('/')
  Future<ModelList<EducationModel>> fetch();

  @override
  @GET('/{id}')
  Future<EducationDetailModel> getDetail({
    @Path() required Id id,
  });
}
