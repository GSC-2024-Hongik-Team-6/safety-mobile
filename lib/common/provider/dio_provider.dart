import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:safetyedu/common/const/data.dart';

final dioProvider = Provider<Dio>(
  (ref) {
    final dio = Dio(
      BaseOptions(
        baseUrl: apiurl,
      ),
    );

    final logger = PrettyDioLogger();

    dio.interceptors.add(logger);

    return dio;
  },
);
