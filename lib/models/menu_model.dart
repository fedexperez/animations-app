import 'package:flutter/material.dart';

class MenuModel extends ChangeNotifier {
  bool _show = true;

  Color _backgroundColor = Colors.white;
  Color _activeColor = Colors.red.shade600;
  Color _inactiveColor = Colors.grey.shade600;

  bool get getShow => _show;

  set setShow(bool show) {
    _show = show;
    notifyListeners();
  }

  Color get getBackgroundColor => _backgroundColor;

  set setBackgroundColor(Color backgroundColor) {
    _backgroundColor = backgroundColor;
    notifyListeners();
  }

  Color get getActiveColor => _activeColor;

  set setActiveColor(Color activeColor) {
    _activeColor = activeColor;
    notifyListeners();
  }

  Color get getInactiveColor => _inactiveColor;

  set setInactiveColor(Color inactiveColor) {
    _inactiveColor = inactiveColor;
    notifyListeners();
  }
}
