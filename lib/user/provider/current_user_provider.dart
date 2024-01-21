import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/user/const/token.dart';
import 'package:safetyedu/user/model/user_model.dart';
import 'package:safetyedu/user/repository/auth_repository.dart';
import 'package:safetyedu/user/repository/current_user_repository.dart';

final currentUserProvider =
    StateNotifierProvider<CurrentUserStateNotifier, UserState?>((ref) {
  final currentUserRepository = ref.watch(currentUserRepositoryProvider);
  final authRepository = ref.watch(authRepositoryProvider);

  return CurrentUserStateNotifier(
    currentUserRepository: currentUserRepository,
    authRepository: authRepository,
  );
});

/// 현재 로그인된 사용자 정보를 저장하는 StateNotifier입니다.
class CurrentUserStateNotifier extends StateNotifier<UserState?> {
  final CurrentUserRepository currentUserRepository;
  final AuthRepository authRepository;

  CurrentUserStateNotifier({
    required this.currentUserRepository,
    required this.authRepository,
  }) : super(UserLoading()) {
    loadCurrentUser();
  }

  /// 현재 로그인된 사용자 정보를 가져와서, 이를 state로 저장합니다.
  /// ### States
  /// - [UserModel] : 사용자 정보
  /// - [UserError] : 사용자 정보를 불러오는 중 에러가 발생
  /// - [UserLoading] : 사용자 정보를 불러오는 중
  /// - [null] : 사용자 정보가 없음
  Future<void> loadCurrentUser() async {
    final response = currentUserRepository.getCurrentUser();

    state = response;
  }

  Future<void> logout() async {
    state = null;

    isLogined = false;
  }

  Future<UserState> login({
    required String email,
    required String password,
  }) async {
    try {
      state = UserLoading();

      final userCredential = await authRepository.signInWithEmailAndPassword(
        email,
        password,
      );

      if (userCredential.user == null) {
        throw Exception('Wrong email or password');
      }

      final userResponse = UserModel.fromFirebaseUser(userCredential.user!);

      state = userResponse;

      return userResponse;
    } catch (e) {
      state = UserError(message: 'Login Failed: $e');

      return Future.value(state);
    }
  }
}
