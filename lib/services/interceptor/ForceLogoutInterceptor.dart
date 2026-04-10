import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:untitled1/routes/app_routes.dart';
import 'package:untitled1/services/prefrense_services.dart';

class ForceLogoutInterceptor extends Interceptor {
  @override
  void onError(DioException e, ErrorInterceptorHandler handler) {
    if (e.response?.statusCode == 401) {
      log("Unauthorized error detected. Logging out...");
      
      // Clear auth preferences
      SharedPreference().removePreference(SharedPreference.accessToken);
      SharedPreference().removePreference(SharedPreference.login);
      SharedPreference().removePreference(SharedPreference.userData);
      
      // Navigate to login
      AppRoutes.router.go(AppRoutes.login);
    }
    
    super.onError(e, handler);
  }
}
