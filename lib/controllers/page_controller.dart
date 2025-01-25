import 'package:flutter/foundation.dart';

class AppPageController extends ChangeNotifier {
  void Function(int)? _pageChangeCallback;
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void registerPageChange(void Function(int) callback) {
    _pageChangeCallback = callback;
  }

  void changePage(int page) {
    _currentPage = page;
    _pageChangeCallback?.call(page);
    notifyListeners();
  }
}
