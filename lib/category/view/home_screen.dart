import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/category/component/category_card.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/common/const/colors.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const DefaultLayout(
        title: 'Home',
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Learning by Quiz',
                style: CustomTextStyle(
                  textFontSize: 28,
                  textFontWeight: FontWeight.w700,
                  textColor: titleTextColor,
                ),
              ),
              SizedBox(height: 24),
              CategoryCard(
                description: 'What should we do when Earthquake happens?',
                estimatedTime: 5,
                image: Icon(
                  Icons.warning,
                ),
                title: 'Earthquake',
              ),
            ],
          ),
        ));
  }
}
