import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/provider/dio_provider.dart';
import 'package:safetyedu/quiz/model/quiz_model.dart';
import 'package:safetyedu/quiz/model/quiz_status_model.dart';
import 'package:safetyedu/quiz/model/user_answer_model.dart';

part 'quiz_repository.g.dart';

final quizRepositoryProvider = Provider<QuizRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return QuizRepository(dio);
  },
);

@RestApi(baseUrl: '/quiz')
abstract class QuizRepository {
  factory QuizRepository(Dio dio) = _QuizRepository;

  @GET('')
  Future<ModelList<QuizStatusModel>> fetch({
    @Query("educationId") Id? educationId,
  });

  @GET('/{id}')
  Future<QuizDetailModel> getDetail({
    @Path() required Id id,
  });

  @POST('/{id}')
  Future<void> submit({
    @Path() required Id id,
    @Body() required UserAnswerModel userAnswer,
  });
}
