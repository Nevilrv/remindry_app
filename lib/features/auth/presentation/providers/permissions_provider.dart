import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final permissionsProvider = ChangeNotifierProvider((ref) => PermissionsProvider());

class PermissionsProvider extends ChangeNotifier {
  bool _ocrScan = false;
  bool _reminders = false;
  bool _location = false;

  bool get ocrScan => _ocrScan;
  bool get reminders => _reminders;
  bool get location => _location;

  void toggleOcr(bool val) {
    _ocrScan = val;
    notifyListeners();
  }

  void toggleReminders(bool val) {
    _reminders = val;
    notifyListeners();
  }

  void toggleLocation(bool val) {
    _location = val;
    notifyListeners();
  }
}

