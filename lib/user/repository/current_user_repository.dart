import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/provider/firebase_provider.dart';

import 'package:safetyedu/user/model/user_model.dart';

final currentUserRepositoryProvider = Provider<CurrentUserRepository>(
  (ref) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);

    return CurrentUserRepository(
      firebaseAuth: firebaseAuth,
    );
  },
);

class CurrentUserRepository {
  final FirebaseAuth firebaseAuth;

  CurrentUserRepository({
    required this.firebaseAuth,
  });

  UserModel? getCurrentUser() {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      return null;
    }

    return UserModel(
      id: user.uid,
      username: user.displayName ?? user.email!,
    );
  }
}
