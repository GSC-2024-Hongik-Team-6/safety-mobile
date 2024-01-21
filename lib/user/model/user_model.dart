import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

sealed class UserState {}

class UserError extends UserState {
  final String message;

  UserError({
    required this.message,
  });
}

class UserLoading extends UserState {}

@freezed
class UserModel extends UserState with _$UserModel {
  const factory UserModel({
    /// 사용자 아이디
    required String id,

    /// 사용자 이메일
    required String username,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromFirebaseUser(User user) => UserModel(
        id: user.uid,
        username: user.displayName ?? user.email!,
      );
}
