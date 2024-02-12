import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:safetyedu/common/component/custom_text_form_field.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/common/const/colors.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';
import 'package:safetyedu/user/model/user_model.dart';
import 'package:safetyedu/user/provider/current_user_provider.dart';
import 'package:safetyedu/user/view/signup_screen.dart';
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
      safeAreaDisabled: true,
      child: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 60.0),
                    const Text(
                      'LOGIN',
                      style: CustomTextStyle(
                        textFontSize: 24,
                        textFontWeight: FontWeight.w700,
                        textColor: titleTextColor,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextFormField(
                            onChanged: (value) {
                              email = value;
                            },
                            hintText: 'Email',
                          ),
                          const SizedBox(height: 12.0),
                          CustomTextFormField(
                            onChanged: (value) {
                              password = value;
                            },
                            hintText: 'Password',
                            obscureText: true,
                          ),
                          const SizedBox(height: 12.0),
                          // 로그인 버튼
                          ElevatedButton(
                            onPressed: currentUserState is UserLoading
                                ? null
                                : () {
                                    ref
                                        .read(currentUserProvider.notifier)
                                        .login(
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                currentUserState is UserLoading
                                    ? 'Wait for a second...'
                                    : 'LOGIN',
                                style: const CustomTextStyle(
                                  textFontWeight: FontWeight.w600,
                                  textFontSize: 18,
                                  textColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    if (currentUserState is UserError)
                      Text(
                        currentUserState.message,
                        style: const CustomTextStyle(
                          textFontSize: 16,
                          textColor: Colors.red,
                        ),
                      ),
                    const SocialLoginButtonList(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const CustomTextStyle(
                            textFontSize: 16,
                            textColor: inputHintTextColor,
                          ),
                          children: [
                            const TextSpan(
                              text: 'If not yet a member, ',
                            ),
                            TextSpan(
                              text: 'Sign Up',
                              style: const TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.pushNamed(
                                    SignUpScreen.routeName,
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SocialLoginButtonList extends StatelessWidget {
  const SocialLoginButtonList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
