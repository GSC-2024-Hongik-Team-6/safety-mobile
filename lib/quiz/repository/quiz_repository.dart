import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:safetyedu/common/model/model_list.dart';
import 'package:safetyedu/common/model/model_list_meta.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/common/repository/model_list_repository_interface.dart';
import 'package:safetyedu/quiz/model/quiz_model.dart';

class QuizRepository implements IModelListRepository {
  @override
  Future<ModelList<QuizModel>> fetch() async {
    // Load JSON data from the file
    const filepath = 'asset/files/quiz/quiz_data.json';
    final String jsonString = await rootBundle.loadString(filepath);
    final jsonData = json.decode(jsonString);

    // Parse JSON data for items
    final List<dynamic> jsonItems = jsonData['items'];
    final List<QuizModel> quizzes = jsonItems.map((item) {
      final QuizType type = item['type'] == 'MULTIPLE_CHOICE'
          ? QuizType.multipleChoice
          : QuizType.order;

      late QuizItemModel quizItem;

      if (type == QuizType.multipleChoice) {
        quizItem = QuizItemMultipleChoice(
          description: item['item']['description'] as String,
          options: (item['item']['options'] as List<dynamic>)
              .map<Option>(
                  (option) => Option.fromJson(option as Map<String, dynamic>))
              .toList(),
          answer: item['item']['answer'] as int,
        );
      } else {
        quizItem = QuizItemOrdering(
          description: item['item']['description'] as String,
          options: (item['item']['options'] as List<dynamic>)
              .map<Option>(
                  (option) => Option.fromJson(option as Map<String, dynamic>))
              .toList(),
        );
      }

      return QuizModel(
        id: item['id'] as Id,
        type: type,
        item: quizItem,
      );
    }).toList();

    // Parse JSON data for meta
    final ModelListMeta meta =
        ModelListMeta.fromJson(jsonData['meta'] as Map<String, dynamic>);

    // Create ModelList instance
    final ModelList<QuizModel> quizList =
        ModelList<QuizModel>(items: quizzes, meta: meta);

    return quizList;
  }
}
