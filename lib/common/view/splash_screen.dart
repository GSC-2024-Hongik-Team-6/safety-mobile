import 'package:flutter/material.dart';
import 'package:safetyedu/common/const/colors.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';

/// SplashPage는 앱이 실행되면 가장 먼저 보이는 화면
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static String get routeName => 'splash';

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: primaryColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Todo: 로고 이미지가 제작되면 해당 이미지로 변경해야 함
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.security_outlined,
                      size: MediaQuery.of(context).size.width / 2,
                    ),
                    const SizedBox(height: 16),
                    const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            const Text(
              'Resque Me',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontFamily: 'Cabin',
                fontWeight: FontWeight.w700,
                height: 0.01,
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
