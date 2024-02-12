import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/provider/dio_provider.dart';
import 'package:safetyedu/common/repository/model_list_repository_interface.dart';
import 'package:safetyedu/quiz/model/quiz_model.dart';

part 'quiz_repository.g.dart';

final quizRepositoryProvider = Provider<QuizRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return QuizRepository(dio);
  },
);

@RestApi()
abstract class QuizRepository implements IDetailRepository<QuizDetailModel> {
  factory QuizRepository(Dio dio) = _QuizRepository;

  @override
  @GET('/quiz')
  Future<ModelList<QuizDetailModel>> fetch();

  @override
  @GET('/quiz/{id}')
  Future<QuizDetailModel> getDetail({
    @Path() required Id id,
  });
}
