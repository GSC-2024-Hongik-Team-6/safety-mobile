import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_list_meta.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/provider/dio_provider.dart';
import 'package:safetyedu/common/repository/model_list_repository_interface.dart';
import 'package:safetyedu/quiz/model/quiz_model.dart';

final quizRepositoryProvider = Provider<QuizRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return QuizRepository(dio);
  },
);

class QuizRepository implements IDetailRepository<QuizDetailModel> {
  final Dio dio;

  QuizRepository(this.dio);

  @override
  Future<ModelList<QuizDetailModel>> fetch() async {
    return Future.value(ModelList<QuizDetailModel>(
      data: const [],
      meta: const ModelListMeta(count: 0),
    ));
  }

  @override
  Future<QuizDetailModel> getDetail({
    required Id id,
  }) async {
    final response = await dio.get('/quiz/$id');

    if (response.data['type'] == 'MULTIPLE_CHOICE') {
      return QuizDetailModel(
        id: id,
        type: QuizType.multipleChoice,
        data: QuizItemMultipleChoice.fromJson(
          response.data['data'],
        ),
      );
    } else {
      return QuizDetailModel(
        id: id,
        type: QuizType.order,
        data: QuizItemOrdering.fromJson(
          response.data['data'],
        ),
      );
    }
  }
}
