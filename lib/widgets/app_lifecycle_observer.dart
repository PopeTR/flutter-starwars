import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/widgets.dart';

class LifecycleObserver extends WidgetsBindingObserver {
  LifecycleObserver({required this.audioPlayer});
  AssetsAudioPlayer audioPlayer;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App is resumed, do nothing
      audioPlayer.play();
    } else {
      // App is paused, inactive, or terminated, stop the audio
      audioPlayer.pause();
    }
  }
}
