import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicNotifier extends StateNotifier<bool> {
  MusicNotifier() : super(false);

  void toggleMute() {
    state = !state;
  }
}

final musicProvider = StateNotifierProvider<MusicNotifier, bool>((ref) {
  return MusicNotifier();
});
