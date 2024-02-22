import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/provider/dio_provider.dart';
import 'package:safetyedu/common/provider/env_provider.dart';
import 'package:safetyedu/common/repository/model_list_repository_interface.dart';
import 'package:safetyedu/pose/model/action_detail_model.dart';
import 'package:safetyedu/pose/model/action_model.dart';

part 'action_repository.g.dart';

final actionRepositoryProvider = Provider<ActionRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final env = ref.watch(envProvider);

    return ActionRepository(dio, baseUrl: '${env.actionApiUrl}/action');
  },
);

@RestApi()
abstract class ActionRepository implements IDetailRepository<ActionModel> {
  factory ActionRepository(Dio dio, {String baseUrl}) = _ActionRepository;

  @override
  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<ModelList<ActionModel>> fetch();

  @override
  @GET('/{id}')
  @Headers({'accessToken': 'true'})
  Future<ActionDetailModel> getDetail({
    @Path() required Id id,
  });
}
