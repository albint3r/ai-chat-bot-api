import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_intercept_to_curl/dio_intercept_to_curl.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:l/l.dart';

@module
abstract class RegisterModule {
  @injectable
  BaseOptions getDioBaseOptions() {
    final headers = {
      HttpHeaders.acceptHeader: Headers.jsonContentType,
    };
    return BaseOptions(
      baseUrl: 'http://192.168.1.71:8000',
      headers: headers,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );
  }

  @injectable
  Iterable<Interceptor> getInterceptors() {
    if (kDebugMode) {
      return [
        LogInterceptor(logPrint: l.d),
        DioInterceptToCurl(),
      ];
    }
    return [];
  }

  @singleton
  Dio getDio(
    BaseOptions options,
    Iterable<Interceptor> interceptors,
  ) {
    final dio = Dio(options);
    dio.interceptors.addAll(interceptors);
    // ..add(auth);
    return dio;
  }
}
