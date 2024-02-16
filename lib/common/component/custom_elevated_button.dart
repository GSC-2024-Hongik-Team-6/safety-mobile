import 'package:flutter/material.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/common/const/colors.dart';

class CustomElevatedBotton extends StatelessWidget {
  final VoidCallback? onPressed;

  final String text;

  final Color? backgroundColor;

  final Color? textColor;

  final double? fontSize;

  const CustomElevatedBotton({
    super.key,
    this.onPressed,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyles.titleTextStyle.copyWith(
          color: textColor ?? Colors.white,
          fontSize: fontSize ?? 18.0,
        ),
      ),
    );
  }
}
