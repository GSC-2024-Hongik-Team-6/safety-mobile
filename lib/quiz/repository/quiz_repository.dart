import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/quiz/model/quiz_model.dart';

final quizRepositoryProvider = Provider<QuizRepository>(
  (ref) => QuizRepository(),
);

class QuizRepository {
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
