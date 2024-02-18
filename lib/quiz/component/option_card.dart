import 'package:flutter/material.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/common/const/colors.dart';

class OptionCard extends StatelessWidget {
  final String? imageUrl;
  final String? description;
  final bool isSelected;

  const OptionCard({
    super.key,
    required this.imageUrl,
    required this.description,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    late final Color buttonColor;

    if (isSelected) {
      buttonColor = selectedOptionButtonColor;
    } else if (description!.isEmpty) {
      buttonColor = Colors.grey;
    } else {
      buttonColor = Colors.white;
    }

    return Container(
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? selectedOptionButtonBorderColor : Colors.white,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(2, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          if (imageUrl != null)
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Image.network(imageUrl!),
            ),
          if (description != null)
            Text(
              description!,
              style: TextStyles.titleTextStyle.copyWith(
                fontSize: 18.0,
              ),
            ),
        ],
      ),
    );
  }
}
