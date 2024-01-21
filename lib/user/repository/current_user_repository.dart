// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:safetyedu/user/model/user_model.dart';
import 'package:safetyedu/user/provider/firebase_auth_provider.dart';

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
