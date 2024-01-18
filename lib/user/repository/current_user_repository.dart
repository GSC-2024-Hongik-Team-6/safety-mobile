import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/user/model/user_model.dart';

final currentUserRepositoryProvider = Provider(
  (ref) => CurrentUserRepository(),
);

class CurrentUserRepository {
  Future<UserModel> getCurrentUser() async {
    // 2초 간 기다린 후, 현재 로그인된 사용자 정보 반환
    await Future.delayed(const Duration(seconds: 2));
    return const UserModel(
      id: 'test',
      username: 'nx006',
    );
  }
}
