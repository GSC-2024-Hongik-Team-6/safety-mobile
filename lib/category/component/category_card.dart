// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:safetyedu/common/const/colors.dart';

class CategoryCard extends StatelessWidget {
  /// 카테고리 제목
  final String title;

  /// 카테고리 설명
  final String description;

  /// 이미지
  final Widget image;

  /// 예상 시간(분)
  final int estimatedTime;

  const CategoryCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.estimatedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: inputBorderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image widget
            SizedBox(
              width: 80,
              height: 80,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: image,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // title
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: titleTextColor,
                    ),
                  ),

                  // description
                  Text(
                    description,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: descriptionTextColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // estimated time
                  Row(
                    children: [
                      const Icon(
                        Icons.watch_later_outlined,
                        color: hilightColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$estimatedTime MINUTES',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: hilightColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
