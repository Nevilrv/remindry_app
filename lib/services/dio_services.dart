import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../core/constant/api_const.dart' show ApiConsts;
import 'interceptor/ApiTokenInterceptor.dart';
import 'interceptor/ForceLogoutInterceptor.dart';
import 'interceptor/JwtTokenInjector.dart';

class AppDioService {
  static final Dio _dio = () {
    var dio = Dio();
    log('ApiConsts.baseUrl :::::::::::::::: ${ApiConsts.baseUrl}');
    BaseOptions options = BaseOptions(
      baseUrl: ApiConsts.baseUrl,
      connectTimeout: Duration(minutes: 2),
      receiveTimeout: Duration(minutes: 2),
    );
    dio.options = options;
    dio.interceptors
      ..add(ForceLogoutInterceptor())
      ..add(ApiTokenInterceptor())
      ..add(JwtTokenInjector())
      ..add(LogInterceptor(responseBody: true, requestHeader: true, request: true, responseHeader: true, error: true));
    return dio;
  }();

  static Dio getDioInstance() {
    debugPrint("base1: ${ApiConsts.baseUrl} ${_dio.options.baseUrl}");
    return _dio;
  }
}
