import 'package:flutter/material.dart';
import 'package:safetyedu/common/const/colors.dart';
import 'package:safetyedu/education/model/education_model.dart';

class EducationCard extends StatelessWidget {
  /// 카테고리 제목
  final String title;

  /// 카테고리 설명
  final String description;

  /// 이미지
  final Widget image;

  /// Detail 설명
  final String detail;

  const EducationCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.detail,
  });

  factory EducationCard.fromModel(EducationModel model) {
    return EducationCard(
      title: model.title,
      description: model.description,
      image: const Icon(
        Icons.image,
      ),
      detail: model.detail,
    );
  }

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
                ],
              ),
            ),
            const Icon(
              Icons.note_add,
              color: primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
