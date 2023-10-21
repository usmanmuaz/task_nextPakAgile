import 'package:flutter/material.dart';

class SelectedTileProvider with ChangeNotifier {
  Set<int> _visibleIndexes = {};

  bool isVisible(int index) {
    return _visibleIndexes.contains(index);
  }

  void toggleVisibility(int index) {
    if (_visibleIndexes.contains(index)) {
      _visibleIndexes.remove(index);
    } else {
      _visibleIndexes.add(index);
    }
    notifyListeners();
  }
}
