import 'package:flutter/material.dart';

class MusicProvider extends ChangeNotifier {
  bool _isMuted = false;
  bool get isMuted => _isMuted;
  void toggleMute() {
    _isMuted = !_isMuted;
    notifyListeners();
  }
}
