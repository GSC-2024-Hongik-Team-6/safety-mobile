import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_list_meta.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/repository/model_list_repository_interface.dart';
import 'package:safetyedu/quiz/model/quiz_model.dart';
import 'package:safetyedu/quiz/model/quiz_status_model.dart';

final quizRepositoryProvider = Provider<QuizRepository>(
  (ref) => QuizRepository(),
);

class QuizRepository implements IModelListRepository {
  final List<QuizStatusModel> items = [
    const QuizStatusModel(isSolved: false, id: '0'),
    const QuizStatusModel(isSolved: false, id: '1'),
  ];

  @override
  Future<ModelList<QuizStatusModel>> fetch() async {
    final meta = ModelListMeta(count: items.length);

    return Future.delayed(
      const Duration(milliseconds: 500),
      () => ModelList(
        items: items,
        meta: meta,
      ),
    );
  }

  Future<QuizDetailModel> getDetail({required Id id}) async {
    const filepath = 'asset/files/quiz/quiz_data.json';
    final jsonString = await rootBundle.loadString(filepath);
    final jsonData = json.decode(jsonString) as List;

    final List<QuizDetailModel> quizList = jsonData.map((item) {
      final QuizType type = item['type'] == 'MULTIPLE_CHOICE'
          ? QuizType.multipleChoice
          : QuizType.order;

      late QuizItemModel quizItem;

      if (type == QuizType.multipleChoice) {
        quizItem = QuizItemMultipleChoice(
          description: item['item']['description'] as String,
          options: (item['item']['options'] as List).map((e) {
            return QuizOption(
              id: e['id'] as int,
              description: e['description'] as String,
              imageUrl: e['imageUrl'] as String?,
            );
          }).toList(),
          answer: item['item']['answer'] as int,
        );
      } else {
        quizItem = QuizItemOrdering(
          description: item['item']['description'] as String,
          options: (item['item']['options'] as List).map((e) {
            return QuizOption(
              id: e['id'] as int,
              description: e['description'] as String,
              imageUrl: e['imageUrl'] as String?,
            );
          }).toList(),
        );
      }

      return QuizDetailModel(
        id: item['id'] as String,
        type: type,
        item: quizItem,
      );
    }).toList();

    final quiz = quizList.firstWhere((element) => element.id == id);

    return quiz;
  }
}
