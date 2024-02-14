import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:safetyedu/education/component/education_detail_popup.dart';
import 'package:safetyedu/education/model/education_detail_model.dart';
import 'package:safetyedu/education/model/education_model.dart';
import 'package:safetyedu/education/provider/education_provider.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/common/const/colors.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';

import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/quiz/component/quiz_button.dart';
import 'package:safetyedu/quiz/model/quiz_status_model.dart';
import 'package:safetyedu/quiz/view/quiz_detail_screen.dart';

class EducationDetailScreen extends ConsumerStatefulWidget {
  static const routeName = '/education-detail';

  final Id cid;

  const EducationDetailScreen({
    super.key,
    required this.cid,
  });

  @override
  ConsumerState<EducationDetailScreen> createState() =>
      _EducationDetailScreenState();
}

class _EducationDetailScreenState extends ConsumerState<EducationDetailScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(educationProvider.notifier).getDetail(id: widget.cid);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(educationDetailProvider(widget.cid));

    if (state == null) {
      return const DefaultLayout(
        title: '',
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      title: 'Learning by Quiz',
      appBar: _buildEducationAppBar(context: context, education: state),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: state is EducationDetailModel
            ? QuizListTile(quizList: state.quizzes)
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  AppBar _buildEducationAppBar({
    required BuildContext context,
    required EducationModel education,
  }) {
    return AppBar(
      title: Text(
        'quiz',
        style: TextStyles.subTitleTextStyle.copyWith(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: primaryColor,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 110),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      education.title,
                      style: TextStyles.titleTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      education.description,
                      style: TextStyles.descriptionTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: EducationDetailPopUp.fromModel(education),
                    ),
                  );
                },
                icon: Container(
                  decoration: BoxDecoration(
                    color: secondPrimaryColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(13.0),
                    child: Icon(
                      Icons.book,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizListTile extends StatelessWidget {
  final List<QuizStatusModel> quizList;

  const QuizListTile({
    super.key,
    required this.quizList,
  });

  @override
  Widget build(BuildContext context) {
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
