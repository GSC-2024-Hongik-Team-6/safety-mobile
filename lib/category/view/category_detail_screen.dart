// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/common/const/colors.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';

import 'package:safetyedu/common/model/model_with_id.dart';

class CategoryDetailScreen extends StatelessWidget {
  static const routeName = '/category-detail';

  final Id cid;

  const CategoryDetailScreen({
    super.key,
    required this.cid,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Learning by Quiz',
      appBarBackgroundColor: primaryColor,
      appBarBottom: PreferredSize(
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
              Container(
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
            ],
          ),
        ),
      ),
      child: Center(
        child: Text('CategoryDetailScreen: $cid'),
      ),
    );
  }
}
