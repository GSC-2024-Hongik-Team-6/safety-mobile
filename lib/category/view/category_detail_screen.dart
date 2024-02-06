import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/category/model/category_detail_model.dart';
import 'package:safetyedu/category/provider/category_provider.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/common/const/colors.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';

import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/quiz/component/quiz_button.dart';
import 'package:safetyedu/quiz/model/quiz_model.dart';

class CategoryDetailScreen extends ConsumerStatefulWidget {
  static const routeName = '/category-detail';

  final Id cid;

  const CategoryDetailScreen({
    super.key,
    required this.cid,
  });

  @override
  ConsumerState<CategoryDetailScreen> createState() =>
      _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends ConsumerState<CategoryDetailScreen> {
  final List<IconData> quizIcons = [
    Icons.star,
    Icons.star,
    Icons.star,
    Icons.star,
    Icons.star,
    // Add more icons as needed
  ];

  @override
  void initState() {
    super.initState();

    ref.read(categoryProvider.notifier).getDetail(id: widget.cid);
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(categoryDetailProvider(widget.cid));

    if (category == null || category is! CategoryDetailModel) {
      return const DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      title: 'Learning by Quiz',
      appBar: _buildCategoryAppBar(context: context, category: category),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: QuizListTile(quizList: category.quizzes),
      ),
    );
  }

  AppBar _buildCategoryAppBar({
    required BuildContext context,
    required CategoryDetailModel category,
  }) {
    return AppBar(
      title: Text(
        category.title,
        style: const CustomTextStyle(
          textFontSize: 16,
          textFontWeight: FontWeight.w500,
          textColor: Colors.white,
        ),
      ),
      backgroundColor: primaryColor,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quiz',
                    style: CustomTextStyle(
                      textFontSize: 28,
                      textFontWeight: FontWeight.w700,
                      textColor: Colors.white,
                    ),
                  ),
                  Text(
                    'Let’s solve alternative quizes',
                    style: CustomTextStyle(
                      textFontSize: 20,
                      textFontWeight: FontWeight.w400,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                          child: Container(
                        height: 300,
                        width: 300,
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            category.detail,
                          ),
                        ),
                      ));
                    },
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
  final List<QuizItemModel> quizList;

  const QuizListTile({
    super.key,
    required this.quizList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 25,
      itemBuilder: (context, index) {
        // final quiz = quizList[index];

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
          children: const [
            QuizButton(
              icon: Icons.star,
              id: '1',
            ),
          ],
        );
      },
    );
  }
}
