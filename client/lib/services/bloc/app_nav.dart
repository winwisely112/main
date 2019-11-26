import 'package:flutter/foundation.dart';

class AppNavigation with ChangeNotifier {
  AppNavigation.init(int indexes, int initialIndex) {
    if (_menuList.isEmpty) {
      _length = indexes + 1;
      _setIndex(initialIndex);
    }
  }

  List<bool> _menuList = <bool>[];
  int _length = 0;
  List<bool> get selections => _menuList;

  void setIndex(int index) {
    _setIndex(index);
    notifyListeners();
  }

  void _setIndex(int index) {
    final List<bool> list = List<bool>.filled(_length, false);
    list[index] = true;
    _menuList = list;
  }
}
