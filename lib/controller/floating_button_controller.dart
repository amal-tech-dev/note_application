import 'package:flutter/material.dart';

class FloatingButtonController with ChangeNotifier {
  bool isExpanded = false;

  expand() {
    isExpanded = true;
    notifyListeners();
  }

  shrink() {
    isExpanded = false;
    notifyListeners();
  }
}
