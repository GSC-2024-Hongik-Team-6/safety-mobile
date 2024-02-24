import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:safetyedu/user/model/user_model.dart';
import 'package:safetyedu/user/provider/current_user_provider.dart';

final authProvider = Provider<AuthNotifier>((ref) {
  return AuthNotifier(ref: ref);
});

class AuthNotifier extends ChangeNotifier {
  final Ref ref;

  AuthNotifier({required this.ref}) {
    ref.listen<UserState?>(currentUserProvider, (previous, next) {
      // currentUserProvider의 state가 변경될 시 AuthNotifier에서 이를 감지합니다.
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  void logout() {
    ref.read(currentUserProvider.notifier).logout();
  }

  /// 앱을 처음 시작했을 때 토큰이 존재하는 지를 확인하고,
  /// [LoginScreen] 또는 [HomeScreen]으로 이동한다.
  ///
  /// - Token이 존재: [HomeScreen]
  /// - Token이 존재하지 않음: [LoginScreen]
  String? redirectLogic(BuildContext _, GoRouterState goState) {
    final user = ref.read(currentUserProvider);

    final logginIn = goState.fullPath == '/login';

    final signUpIn = goState.fullPath == '/sign-up';

    /// 회원 가입 중이라면 그대로 두기
    if (signUpIn) {
      return null;
    }

    /// 현재 위치가 로그인 페이지라면 그대로 두고, 아니라면 로그인 페이지로 이동시키는 로직
    ///
    /// Refresh되는 것을 방지하기 위해 해당 로직을 사용합니다
    /// (그냥 /login으로 이동시키면 이미 login 페이지에 있는데도 불구하고 다시 login으로 이동하는
    /// 문제가 있을 수 있음)
    String? goToLoginScreen() {
      return logginIn ? null : '/login';
    }

    return switch (user) {
      // 만약 유저 정보가 없다면 로그인 페이지로 이동한다
      null => goToLoginScreen(),

      // 유저 정보 Error일 시에도, 로그인 페이지로 이동한다
      UserError() => goToLoginScreen(),

      // 사용자 정보가 존재할 때, 현재 위치가 로그인 페이지 혹은 SplashPage라면 home으로 이동
      // 그 외 페이지의 경우는 그대로 둔다
      UserModel() =>
        (logginIn || goState.fullPath == '/splash') ? '/home' : null,

      // 사용자 정보를 불러오는 중이라면, 일단 그대로 두기
      UserLoading() => null,
    };
  }
}
