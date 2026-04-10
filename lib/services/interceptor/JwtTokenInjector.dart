import 'package:dio/dio.dart';

class JwtTokenInjector extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // debugPrint("SettingsController.userToken-------token-------> ${SettingsController.userToken}");

    // options.headers["jwtoken"] = SettingsController.userToken ?? "";
    //  handler.next(options);
    super.onRequest(options, handler);
  }
}
