import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/education/component/education_list_view.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Learning by Quiz',
            style: TextStyles.titleTextStyle,
          ),
          SizedBox(height: 24),
          Expanded(child: EducationListView()),
        ],
      ),
    );
  }
}
