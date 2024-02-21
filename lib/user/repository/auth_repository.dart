import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safetyedu/common/provider/firebase_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);

  return AuthRepository(
    firebaseAuth: firebaseAuth,
  );
});

class AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepository({
    required this.firebaseAuth,
  });

  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return firebaseAuth.signOut();
  }
}
