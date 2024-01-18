import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/layout.dart/default_layout.dart';
import 'package:safetyedu/user/provider/current_user_provider.dart';

class LoginScreen extends ConsumerWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(currentUserProvider.notifier).login();
          },
          child: const Text('로그인'),
        ),
      ),
    );
  }
}
