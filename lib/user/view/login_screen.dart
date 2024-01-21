import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/component/custom_text_form_field.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/common/const/colors.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';
import 'package:safetyedu/user/model/user_model.dart';
import 'package:safetyedu/user/provider/current_user_provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final currentUserState = ref.watch(currentUserProvider);

    return DefaultLayout(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 100.0),
                const Text(
                  '로그인',
                  style: CustomTextStyle(
                    textFontSize: 24,
                    textFontWeight: FontWeight.w700,
                    textColor: titleTextColor,
                  ),
                ),
                const SizedBox(height: 20.0),
                CustomTextFormField(
                  onChanged: (value) {},
                  hintText: 'Email',
                ),
                const SizedBox(height: 12.0),
                CustomTextFormField(
                  onChanged: (value) {},
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: currentUserState is UserLoading
                      ? null
                      : () {
                          ref.read(currentUserProvider.notifier).login(
                                email: email,
                                password: password,
                              );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        currentUserState is UserLoading
                            ? const Text('Wait for a second...',
                                style: CustomTextStyle(
                                  textFontWeight: FontWeight.w600,
                                  textFontSize: 18,
                                  textColor: Colors.white,
                                ))
                            : const Text(
                                'LOGIN',
                                style: CustomTextStyle(
                                  textFontWeight: FontWeight.w600,
                                  textFontSize: 18,
                                  textColor: Colors.white,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SocialLoginButton(
                buttonType: SocialLoginButtonType.google,
                onPressed: () {},
                fontSize: 18,
                borderRadius: 12.0,
              ),
              const SizedBox(height: 12.0),
              SocialLoginButton(
                buttonType: SocialLoginButtonType.github,
                onPressed: () {},
                fontSize: 18.0,
                borderRadius: 12.0,
              ),
              const SizedBox(height: 12.0),
              SocialLoginButton(
                buttonType: SocialLoginButtonType.apple,
                onPressed: () {},
                fontSize: 18.0,
                borderRadius: 12.0,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Text(
              'By signing into our service, '
              'you agree to our Terms and Privacy Policy',
              textAlign: TextAlign.center,
              style: CustomTextStyle(
                textFontSize: 16,
                textColor: inputHintTextColor,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
