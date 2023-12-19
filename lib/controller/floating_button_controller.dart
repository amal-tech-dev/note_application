import 'package:flutter/material.dart';

class FloatingButtonController with ChangeNotifier {
  bool isExpanded = false;

  // expand floating action button
  expand() {
    isExpanded = true;
    notifyListeners();
  }

  // shrink floating action button
  shrink() {
    isExpanded = false;
    notifyListeners();
  }
}
