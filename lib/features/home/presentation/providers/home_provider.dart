import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = ChangeNotifierProvider((ref) => HomeProvider());

class HomeProvider extends ChangeNotifier {
  int _selectedTab = 0;
  int get selectedTab => _selectedTab;

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
}

