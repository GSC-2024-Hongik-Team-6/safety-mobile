import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:safetyedu/common/component/custom_elevated_button.dart';
import 'package:safetyedu/common/component/custom_text_form_field.dart';
import 'package:safetyedu/common/component/custom_text_style.dart';
import 'package:safetyedu/common/const/colors.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';
import 'package:safetyedu/user/model/user_model.dart';
import 'package:safetyedu/user/provider/current_user_provider.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static String routeName = '/sign-up';

  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  String name = '';
  String email = '';
  String password = '';
  String checkingPassword = '';

  @override
  Widget build(BuildContext context) {
    final currentUserState = ref.watch(currentUserProvider);

    return DefaultLayout(
      safeAreaDisabled: true,
      title: '',
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
                    Text(
                      'REGISTER',
                      style: TextStyles.titleTextStyle.copyWith(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextFormField(
                            onChanged: (value) {
                              name = value;
                            },
                            hintText: 'Name',
                          ),
                          const SizedBox(height: 12.0),
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
                          CustomTextFormField(
                            onChanged: (value) {
                              checkingPassword = value;
                            },
                            hintText: 'Checking Password',
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                    if (currentUserState is UserError)
                      Text(
                        currentUserState.message,
                        style: TextStyles.descriptionTextStyle.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    // 회원 가입 버튼
                    CustomElevatedBotton(
                      text: 'REGISTER',
                      onPressed: currentUserState is UserLoading
                          ? null
                          : () {
                              ref.read(currentUserProvider.notifier).signUp(
                                    username: name,
                                    email: email,
                                    password: password,
                                    passwordConfirm: checkingPassword,
                                  );
                              if (currentUserState is UserModel) {
                                context.pop();
                              }
                            },
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
