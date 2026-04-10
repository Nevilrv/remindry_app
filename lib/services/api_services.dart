import 'package:dio/dio.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:untitled1/routes/app_routes.dart';
import 'package:untitled1/services/dio_services.dart';

class ApiResponse<T> {
  final T? data;
  final String? message;
  final bool isSuccess;
  final int? statusCode;

  ApiResponse({this.data, this.message, this.isSuccess = false, this.statusCode});

  factory ApiResponse.success(T data, {String? message, int? statusCode}) {
    return ApiResponse(data: data, message: message ?? "Success", isSuccess: true, statusCode: statusCode);
  }

  factory ApiResponse.error(String message, {int? statusCode, T? data}) {
    return ApiResponse(data: data, message: message, isSuccess: false, statusCode: statusCode);
  }
}

class ApiService {
  final Dio _dio = AppDioService.getDioInstance();

  Future<ApiResponse<T>> request<T>(
    String url, {
    String method = 'GET',
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(dynamic)? fromJson,
  }) async {
    final bool shouldShowLoader = method != 'GET';
    final context = AppRoutes.navigatorKey.currentContext;
    if (shouldShowLoader && context != null && context.mounted) {
      context.loaderOverlay.show();
    }
    try {
      final response = await _dio.request(
        url,
        data: data,
        queryParameters: queryParameters,
        options: (options ?? Options()).copyWith(method: method),
      );

      final success = response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300;

      if (success) {
        final dynamic rawData = response.data;
        T? transformedData;
        String? message;

        if (rawData is Map<String, dynamic>) {
          message = rawData['message']?.toString() ?? response.statusMessage;
          if (fromJson != null) {
            transformedData = fromJson(rawData);
          } else {
            // If No fromJson, but user expects a specific type T, this might still fail.
            // But we try to return the 'data' part if it exists, as it's common.
            final dynamic extracted = rawData['data'] ?? rawData;
            if (extracted is T) {
              transformedData = extracted;
            } else {
              transformedData = null; // Can't cast, let user handle null data
            }
          }
        } else {
          transformedData = fromJson != null ? fromJson(rawData) : rawData;
          message = response.statusMessage;
        }

        return ApiResponse.success(transformedData!, message: message, statusCode: response.statusCode);
      } else {
        return ApiResponse.error(response.statusMessage ?? "Request failed", statusCode: response.statusCode);
      }
    } on DioException catch (e) {
      String errorMessage = "Something went wrong";
      int? statusCode = e.response?.statusCode;

      if (e.response != null && e.response?.data != null) {
        final errorData = e.response?.data;
        if (errorData is Map && errorData.containsKey('message')) {
          errorMessage = errorData['message'].toString();
        } else if (errorData is String) {
          errorMessage = errorData;
        } else {
          errorMessage = e.response?.statusMessage ?? e.message ?? "Server error";
        }
      } else {
        errorMessage = e.message ?? "Network connection lost";
      }

      return ApiResponse.error(errorMessage, statusCode: statusCode);
    } finally {
      final context = AppRoutes.navigatorKey.currentContext;
      if (shouldShowLoader && context != null && context.mounted) {
        context.loaderOverlay.hide();
      }
    }
  }

  // Helper Methods
  Future<ApiResponse<T>> get<T>(String url, {Map<String, dynamic>? queryParameters, T Function(dynamic)? fromJson}) {
    return request(url, method: 'GET', queryParameters: queryParameters, fromJson: fromJson);
  }

  Future<ApiResponse<T>> post<T>(String url, {dynamic data, T Function(dynamic)? fromJson}) {
    return request(url, method: 'POST', data: data, fromJson: fromJson);
  }

  Future<ApiResponse<T>> put<T>(String url, {dynamic data, T Function(dynamic)? fromJson}) {
    return request(url, method: 'PUT', data: data, fromJson: fromJson);
  }

  Future<ApiResponse<T>> delete<T>(String url, {dynamic data, T Function(dynamic)? fromJson}) {
    return request(url, method: 'DELETE', data: data, fromJson: fromJson);
  }
}
