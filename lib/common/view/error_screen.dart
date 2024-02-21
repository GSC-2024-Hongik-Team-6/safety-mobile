import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safetyedu/common/component/custom_elevated_button.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';
import 'package:safetyedu/common/view/root_tab.dart';
import 'package:safetyedu/common/view/splash_screen.dart';

class ErrorScreen extends StatelessWidget {
  final String message;

  const ErrorScreen({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        child: Center(
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Dont Panic!',
                  style: TextStyles.titleTextStyle,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Something went wrong,\n"
                  "we're working on it.",
                  style: TextStyles.descriptionTextStyle,
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: TextStyles.descriptionTextStyle.copyWith(
                    color: Colors.yellow[700],
                  ),
                ),
              ],
            ),
          ),
          CustomElevatedBotton(
            text: 'Go Home',
            onPressed: () {
              context.goNamed(SplashScreen.routeName);
            },
          )
        ],
      ),
    ));
  }
}
