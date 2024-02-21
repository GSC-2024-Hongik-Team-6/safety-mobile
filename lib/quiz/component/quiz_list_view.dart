import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/quiz/component/quiz_button.dart';
import 'package:safetyedu/quiz/provider/quiz_provider.dart';
import 'package:safetyedu/quiz/view/quiz_detail_screen.dart';

class QuizListView extends ConsumerWidget {
  final Id eid;

  const QuizListView({
    super.key,
    required this.eid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizList = ref.watch(quizListProvider(eid));

    if (quizList == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.builder(
      itemCount: quizList.length,
      itemBuilder: (context, index) {
        final quiz = quizList[index];

        final alignflag = index % 4;

        late MainAxisAlignment align;

        if (alignflag == 0) {
          align = MainAxisAlignment.start;
        } else if (alignflag == 1 || alignflag == 3) {
          align = MainAxisAlignment.center;
        } else {
          align = MainAxisAlignment.end;
        }

        return Row(
          mainAxisAlignment: align,
          children: [
            GestureDetector(
              onTap: () => context.pushNamed(
                QuizDetailScreen.routeName,
                pathParameters: {
                  'eid': eid.toString(),
                  'qid': quiz.id.toString(),
                },
              ),
              child: QuizCard(
                icon: Icons.star,
                id: quiz.id,
              ),
            ),
          ],
        );
      },
    );
  }
}
