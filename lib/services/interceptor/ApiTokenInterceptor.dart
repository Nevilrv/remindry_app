import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../prefrense_services.dart';

class ApiTokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String accessToken = preferences.getString(SharedPreference.accessToken) ?? '';

    if (accessToken.isNotEmpty == true) {
      options.headers["Authorization"] = "Bearer $accessToken";
    }

    log('options.headers["Authorization"] ::::::::::::::::${options.headers["Authorization"]}');
    if (options.data is! FormData) {
      log('options.body ::::::::::::::::::: ${jsonEncode(options.data)}');
    } else {
      log('options.body ::::::::::::::::::: FormData (multipart/form-data)');
    }
    log('options.baseUrl ::::::::::::::::::: ${options.baseUrl}');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data is Map || response.data is List) {
      log("json response is ${jsonEncode(response.data)}");
    } else {
      log("json response is ${response.data.runtimeType}");
    }
    print("json status code is ${response.statusCode}");
    print("json message is ${response.statusMessage}");

    // TODO: implement onResponse
    super.onResponse(response, handler);
  }
}
