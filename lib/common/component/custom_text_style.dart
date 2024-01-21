import 'package:flutter/material.dart';
import 'package:safetyedu/common/const/colors.dart';

class CustomTextStyle extends TextStyle {
  final Color? textColor;
  final double? textFontSize;
  final String? textFontFamily;
  final FontWeight? textFontWeight;
  final double? textHeight;

  const CustomTextStyle({
    this.textColor,
    this.textFontSize,
    this.textFontFamily,
    this.textFontWeight,
    this.textHeight,
  }) : super(
          color: textColor ?? inputHintTextColor,
          fontSize: textFontSize ?? 20,
          fontFamily: textFontFamily ?? 'Cabin',
          fontWeight: textFontWeight ?? FontWeight.w400,
          height: textHeight,
        );
}
