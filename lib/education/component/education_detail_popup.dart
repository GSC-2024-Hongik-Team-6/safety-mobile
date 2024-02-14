import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/education/component/image_list_builder.dart';
import 'package:safetyedu/education/model/education_model.dart';

class EducationDetailPopUp extends StatelessWidget {
  final String title;
  final String detail;
  final List<String>? images;

  factory EducationDetailPopUp.fromModel(EducationModel model) {
    return EducationDetailPopUp(
      title: model.title,
      detail: model.detail,
      images: model.images,
    );
  }

  const EducationDetailPopUp({
    super.key,
    required this.title,
    required this.detail,
    this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyles.titleTextStyle,
        ),
        if (images != null)
          ImageListBuilder(
            images: images!,
          ),
        HtmlWidget(
          detail,
        ),
      ],
    );
  }
}
