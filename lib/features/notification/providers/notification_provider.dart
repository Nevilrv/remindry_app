import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constant/api_const.dart';
import '../../../services/api_services.dart';
import '../model/notification_model.dart';
import '../../../core/constant/app_assets.dart';
import '../../../core/constant/app_theme.dart';

final notificationProvider = ChangeNotifierProvider((ref) => NotificationProvider());

class NotificationProvider extends ChangeNotifier {
  bool _isLeft = true;
  bool _isLoading = false;
  List<NotificationData> _unreadNotifications = [];
  List<NotificationData> _readNotifications = [];

  bool get isLeft => _isLeft;
  bool get isLoading => _isLoading;
  List<NotificationData> get unreadNotifications => _unreadNotifications;
  List<NotificationData> get readNotifications => _readNotifications;

  void isChangeLeft({required bool value}) {
    _isLeft = value;
    notifyListeners();
  }

  Future<void> fetchNotifications({required int status, int cursor = 0}) async {
    _isLoading = true;
    notifyListeners();

    ApiResponse<NotificationResponse> response = await ApiService().get(
      ApiConsts.notification,
      queryParameters: {"status": status, "cursor": cursor, "limit": 100},
      fromJson: (json) => NotificationResponse.fromJson(json),
    );

    if (response.isSuccess && response.data != null) {
      if (status == 0) {
        _unreadNotifications = response.data!.data?.notification ?? [];
      } else {
        _readNotifications = response.data!.data?.notification ?? [];
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> markAllRead() async {
    _isLoading = true;
    notifyListeners();

    ApiResponse response = await ApiService().put(
      ApiConsts.notification,
    );

    if (response.isSuccess) {
      await fetchNotifications(status: 0);
      await fetchNotifications(status: 1);
      _isLeft = false; // Switch to Read tab
    }

    _isLoading = false;
    notifyListeners();
  }

  Map<String, List<NotificationData>> groupNotificationsByDate(List<NotificationData> notifications) {
    Map<String, List<NotificationData>> grouped = {};
    for (var notification in notifications) {
      if (notification.createdAt == null) continue;
      
      DateTime date = notification.createdAt!;
      String key;
      if (isToday(date)) {
        key = "Today";
      } else if (isYesterday(date)) {
        key = "Yesterday";
      } else {
        key = DateFormat('dd MMM yyyy').format(date);
      }

      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]!.add(notification);
    }
    return grouped;
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day;
  }

  String getIconForCategory(String? category) {
    switch (category?.toLowerCase()) {
      case 'urgent':
        return AppAssets.alert;
      case 'medication':
        return AppAssets.tablet;
      case 'health':
        return AppAssets.healthIcon;
      case 'event':
        return AppAssets.eventsIcon;
      case 'warranty':
        return AppAssets.warrantyIcon;
      case 'money':
        return AppAssets.moneyIcon;
      default:
        return AppAssets.notificationIcon;
    }
  }

  Color getColorForCategory(String? category) {
    switch (category?.toLowerCase()) {
      case 'urgent':
        return AppColors.red;
      case 'medication':
        return AppColors.orange;
      case 'health':
        return AppColors.green;
      case 'event':
        return AppColors.purple;
      case 'warranty':
        return AppColors.blueColor;
      case 'money':
        return AppColors.green;
      default:
        return AppColors.primary;
    }
  }
}
