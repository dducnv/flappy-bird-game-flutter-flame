import 'package:flutter/material.dart';

class PlayerProvider extends ChangeNotifier {
  int _score = 0;
  bool _paused = false;
  int get score => _score;
  set score(int score) {
    _score = score;
    notifyListeners();
  }

  bool get paused => _paused;
  set paused(bool paused) {
    _paused = paused;
    notifyListeners();
  }
}
