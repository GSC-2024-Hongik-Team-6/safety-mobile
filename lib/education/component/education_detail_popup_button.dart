import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/education/component/image_list_builder.dart';

class EducationDetailPopUpButton extends StatelessWidget {
  final Widget child;

  final String title;
  final String detail;
  final List<String>? images;

  const EducationDetailPopUpButton({
    super.key,
    required this.child,
    required this.title,
    required this.detail,
    this.images,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        DraggableScrollableSheet(
          builder: (context, scrollController) {
            return EducationDetailPopUp(
              scrollController: scrollController,
              title: title,
              detail: detail,
              images: images,
            );
          },
        );
      },
      icon: child,
    );
  }
}

class EducationDetailPopUp extends StatelessWidget {
  final String title;
  final String detail;
  final List<String>? images;

  final ScrollController scrollController;

  const EducationDetailPopUp({
    super.key,
    required this.title,
    required this.detail,
    this.images,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        controller: scrollController,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
            ),
          ),
        ),
      ),
    );
  }
}
