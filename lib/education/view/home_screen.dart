import 'package:flutter/material.dart';
import 'package:safetyedu/common/const/colors.dart';
import 'package:safetyedu/education/component/education_list_view.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';

import '../../pose/view/action_detail_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Column(
        children: [
          _TopTabBar(),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Padding(
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
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Learning by Doing',
                          style: TextStyles.titleTextStyle,
                        ),
                        SizedBox(height: 24),
                        Expanded(child: ActionDetailView()),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopTabBar extends StatelessWidget {
  const _TopTabBar();

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      tabs: [
        Tab(text: 'Quiz'),
        Tab(text: 'Action'),
      ],
      labelColor: primaryColor,
      unselectedLabelColor: inputHintTextColor,
    );
  }
}
