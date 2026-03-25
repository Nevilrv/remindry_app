import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationProvider = ChangeNotifierProvider((ref) => NotificationProvider());

class NotificationProvider extends ChangeNotifier {
  bool _isLeft = true;

  bool get isLeft => _isLeft;

  void isChangeLeft({required bool value}) {
    _isLeft = value;
    notifyListeners();
  }

  final List<Map<String, String>> notificationsToday = [
    {
      "name": "Urgent | Final Reminder",
      "time": "AI Escalated",
      "msg": "Sorry Headphones Warranty Expires Tomorrow",
      "img": "assets/png/one.jpg",
    },
  ];

  final List<Map<String, String>> notificationsYesterday = [
    {
      "name": "Medication | Time for Antibiotics",
      "time": "AI Escalated",
      "msg": "Take With Food • 8:00 AM Daily",
      "img": "assets/png/one.jpg",
    },
  ];
}
