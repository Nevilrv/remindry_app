import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constant/api_const.dart';
import '../../../../services/api_services.dart';
import '../../../../services/socket_services.dart';
import '../../../auth/model/user_data_model.dart';

final homeProvider = ChangeNotifierProvider.autoDispose((ref) => HomeProvider());

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    // Listen for real-time notifications via socket
    SocketService().on('my_notification', my_notification);
  }

  bool _hasNewNotification = false;
  bool get hasNewNotification => _hasNewNotification;

  void my_notification(dynamic data) {
    debugPrint("Real-time notification received: $data");
    
    if (data is Map && data['status'] == true) {
      _hasNewNotification = true;
      notifyListeners();
    }
  }

  void clearNotificationBadge() {
    if (_hasNewNotification) {
      _hasNewNotification = false;
      notifyListeners();
    }
  }

  int _selectedTab = 0;
  int get selectedTab => _selectedTab;

  // ─── Profile Data ───────────────────────────────────────
  UserResponse? _profileData;
  UserResponse? get profileData => _profileData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().get<UserResponse>(ApiConsts.fetchProfile, fromJson: (json) => UserResponse.fromJson(json));

      if (response.isSuccess) {
        _profileData = response.data;
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  // ─── Carousel ───────────────────────────────────────────
  int _carouselPage = 0;
  int get carouselPage => _carouselPage;

  void setCarouselPage(int index) {
    _carouselPage = index;
    notifyListeners();
  }

  // ─── Category Selection ────────────────────────────────
  int _selectedCategory = 2; // Warranty selected by default
  int get selectedCategory => _selectedCategory;

  void setSelectedCategory(int index) {
    _selectedCategory = index;
    notifyListeners();
  }

  @override
  void dispose() {
    // Remove socket listener when provider is disposed
    SocketService().off('my_notification');
    super.dispose();
  }
}
