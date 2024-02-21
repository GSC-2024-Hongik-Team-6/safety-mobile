import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:safetyedu/common/provider/env_provider.dart';
import 'package:safetyedu/user/provider/firebase_auth_provider.dart';

final dioProvider = Provider<Dio>(
  (ref) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ref.read(envProvider).apiUrl,
      ),
    );

    final firebaseAuth = ref.read(firebaseAuthProvider);
    final firebaseInterceptor = FirebaseDioInterceptor(
      firebaseAuth: firebaseAuth,
    );

    final logger = PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
    );

    dio.interceptors.add(firebaseInterceptor);
    dio.interceptors.add(logger);

    return dio;
  },
);

class FirebaseDioInterceptor extends Interceptor {
  final FirebaseAuth firebaseAuth;

  FirebaseDioInterceptor({
    required this.firebaseAuth,
  });

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey('accessToken')) {
      // Firebase Auth로부터 토큰 가져오기
      final token = await firebaseAuth.currentUser?.getIdToken();

      if (token == null) {
        throw FirebaseAuthException(code: 'token-not-found');
      }

      // 기존 헤더 삭제
      options.headers.remove('accessToken');

      // authorization 헤더 추가
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    super.onRequest(options, handler);
  }
}
