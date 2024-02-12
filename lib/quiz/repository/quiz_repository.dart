import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_list_meta.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/repository/model_list_repository_interface.dart';
import 'package:safetyedu/quiz/model/quiz_model.dart';

final quizRepositoryProvider = Provider<QuizRepository>(
  (ref) => QuizRepository(),
);

class QuizRepository implements IDetailRepository<QuizDetailModel> {
  final quizItemList = [
    const QuizDetailModel(
      id: '0',
      type: QuizType.multipleChoice,
      item: QuizItemMultipleChoice(
        description: '지진 대피소 표시로 올바른 것을 고르세요',
        options: [
          QuizOption(
            id: 0,
            description: '지진 대피소 표시 1',
          ),
          QuizOption(
            id: 1,
            description: '지진 대피소 표시 2',
            imageUrl: 'images/2.jpg',
          ),
          QuizOption(
            id: 2,
            description: '지진 대피소 표시 3',
            imageUrl: 'images/3.jpg',
          ),
          QuizOption(
            id: 3,
            description: '지진 대피소 표시 4',
            imageUrl: 'images/4.jpg',
          ),
        ],
        answer: 1,
      ),
    ),
    const QuizDetailModel(
      id: '1',
      type: QuizType.order,
      item: QuizItemOrdering(
        description: '지진 대피소 표시를 올바른 순서대로 나열하세요',
        options: [
          QuizOption(
            id: 0,
            description: '순서 1',
          ),
          QuizOption(
            id: 1,
            description: '순서 2',
          ),
          QuizOption(
            id: 2,
            description: '순서 3',
          ),
          QuizOption(
            id: 3,
            description: '순서 4',
          ),
        ],
      ),
    ),
  ];

  @override
  Future<QuizDetailModel> getDetail({required Id id}) async {
    final quiz = quizItemList.firstWhere((element) => element.id == id);
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => quiz,
    );
  }

  @override
  Future<ModelList<QuizDetailModel>> fetch() {
    return Future.value(
      ModelList(
        items: List.empty(),
        meta: const ModelListMeta(count: 0),
      ),
    );
  }
}
