import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

extension AudioPlayerExtension on BuildContext {
  void playAudio(AssetsAudioPlayer audioPlayer, bool isMuted) {
    if (isMuted) {
      // Mute the audio
      audioPlayer.setVolume(0);
    } else {
      // Unmute the audio
      audioPlayer.setVolume(1);
    }
  }
}
