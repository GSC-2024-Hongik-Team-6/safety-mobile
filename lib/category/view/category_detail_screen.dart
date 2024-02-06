import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/category/model/category_detail_model.dart';
import 'package:safetyedu/category/provider/category_provider.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/common/const/colors.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';

import 'package:safetyedu/common/model/model_with_id.dart';

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

    if (category is! CategoryDetailModel) {
      return const DefaultLayout(
        child: Center(
          child: Text(
            'Error: Is not a Detail Model',
          ),
        ),
      );
    }

    return DefaultLayout(
      title: 'Learning by Quiz',
      appBar: _buildCategoryAppBar(context: context, category: category),
      child: const Center(
        child: Text('Center'),
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
                            category.description,
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
  final CategoryDetailModel category;

  const QuizListTile({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final quizList = category.quizzes;

    return const Center(
      child: Text(
        'Quiz List Tile',
      ),
    );
  }
}
