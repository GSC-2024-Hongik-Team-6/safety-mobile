import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/education/component/education_detail_popup_button.dart';
import 'package:safetyedu/education/model/education_model.dart';
import 'package:safetyedu/education/provider/education_provider.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/common/const/colors.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';

import 'package:safetyedu/common/model/model_with_id.dart';
import 'package:safetyedu/quiz/component/quiz_list_view.dart';

class EducationDetailScreen extends ConsumerStatefulWidget {
  static const routeName = '/education-detail';

  final Id eid;

  const EducationDetailScreen({
    super.key,
    required this.eid,
  });

  @override
  ConsumerState<EducationDetailScreen> createState() =>
      _EducationDetailScreenState();
}

class _EducationDetailScreenState extends ConsumerState<EducationDetailScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(educationProvider.notifier).getDetail(id: widget.eid);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(educationDetailProvider(widget.eid));

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
        child: QuizListView(eid: widget.eid),
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
              EducationDetailPopUpButton(
                title: education.title,
                detail: education.detail,
                images: education.images,
                child: Container(
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
