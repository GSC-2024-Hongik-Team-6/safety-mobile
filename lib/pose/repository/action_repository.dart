import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/provider/dio_provider.dart';
import 'package:safetyedu/common/repository/model_list_repository_interface.dart';
import 'package:safetyedu/education/model/education_model.dart';

part 'action_repository.g.dart';

final actionRepositoryProvider = Provider<ActionRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return ActionRepository(dio);
  },
);

@RestApi(baseUrl: '/action')
abstract class ActionRepository implements IDetailRepository<EducationModel> {
  factory ActionRepository(Dio dio) = _ActionRepository;

  @override
  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<ModelList<EducationModel>> fetch();

  @override
  @GET('/{id}')
  @Headers({'accessToken': 'true'})
  Future<EducationModel> getDetail({required Id id});
}
