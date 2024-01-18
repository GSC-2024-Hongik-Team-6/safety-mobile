import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/user/const/token.dart';
import 'package:safetyedu/user/model/user_model.dart';
import 'package:safetyedu/user/repository/current_user_repository.dart';

final currentUserProvider =
    StateNotifierProvider<CurrentUserStateNotifier, UserState?>((ref) {
  final currentUserRepository = ref.watch(currentUserRepositoryProvider);

  return CurrentUserStateNotifier(
    currentUserRepository: currentUserRepository,
  );
});

/// 현재 로그인된 사용자 정보를 저장하는 StateNotifier입니다.
class CurrentUserStateNotifier extends StateNotifier<UserState?> {
  final CurrentUserRepository currentUserRepository;

  CurrentUserStateNotifier({
    required this.currentUserRepository,
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
    // 현재 로그인 기능이 구현되어 있지 않아서, 임시로 하드 코딩된 토큰을 사용함
    // TODO: 로그인 기능 구현 후 토큰 저장 기능 사용할 것, 혹은 firebase auth 사용함
    final token = isLogined;

    if (token == false) {
      state = null;
      return;
    }

    final response = await currentUserRepository.getCurrentUser();

    state = response;
  }

  Future<void> logout() async {
    state = null;

    isLogined = false;
  }

  Future<UserState> login() async {
    try {
      state = UserLoading();

      // 토큰 true로 변경
      isLogined = true;

      final userResponse = await currentUserRepository.getCurrentUser();

      state = userResponse;

      return userResponse;
    } catch (e) {
      state = UserError(message: '로그인 실패: $e');

      return Future.value(state);
    }
  }
}
