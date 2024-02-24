import 'package:flutter/material.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/common/const/colors.dart';
import 'package:safetyedu/education/component/education_detail_popup_button.dart';
import 'package:safetyedu/education/model/education_model.dart';
import 'package:safetyedu/pose/model/action_model.dart';

class CategoryCard extends StatelessWidget {
  /// 카테고리 제목
  final String title;

  /// 카테고리 설명
  final String? description;

  /// 이미지
  final String? thumbUrl;

  /// Detail 설명
  final String? detail;

  /// detail 이미지
  final List<String>? images;

  const CategoryCard({
    super.key,
    required this.title,
    required this.description,
    required this.thumbUrl,
    this.detail,
    this.images,
  });

  factory CategoryCard.fromEducationModel(EducationModel model) {
    return CategoryCard(
      title: model.title,
      description: model.description,
      thumbUrl: model.thumbUrl,
      detail: model.detail,
      images: model.images,
    );
  }

  factory CategoryCard.fromActionModel(ActionModel model) {
    return CategoryCard(
      title: model.title,
      description: model.description,
      thumbUrl: model.thumbUrl,
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
                child: thumbUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          thumbUrl!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(Icons.image),
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
                    style: TextStyles.subTitleTextStyle,
                  ),

                  // description
                  Text(
                    description ?? '',
                    style: TextStyles.descriptionTextStyle,
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
            if (detail != null)
              EducationDetailPopUpButton(
                title: title,
                detail: detail!,
                images: images,
                child: const Icon(
                  Icons.book,
                  size: 28,
                  color: primaryColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
