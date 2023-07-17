import 'package:assets_audio_player/assets_audio_player.dart';

void playAudio(AssetsAudioPlayer audioPlayer, bool isMuted) {
  if (isMuted) {
    // Mute the audio
    audioPlayer.setVolume(0);
  } else {
    // Unmute the audio
    audioPlayer.setVolume(1);
  }
}
