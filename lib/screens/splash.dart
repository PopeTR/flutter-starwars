import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:star_wars/screens/tabs.dart';
import '../providers/characters_data.dart';
import '../providers/films_data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen(this.audioPlayer, {super.key});
  final AssetsAudioPlayer audioPlayer;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    if (widget.audioPlayer.isPlaying.value) {
      widget.audioPlayer.stop();
    }
    widget.audioPlayer.open(Audio('assets/music/theme_song.mp3'));
    widget.audioPlayer.play();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => TabsScreen(widget.audioPlayer)));
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<FilmsProvider>(context, listen: false).fetchAllFilms(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Image.asset('assets/images/Star_Wars_Logo2.png')),
              LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return Lottie.asset(
                    'assets/images/yoda.json',
                    repeat: true,
                    reverse: true,
                  );
                } else {
                  return Container();
                }
              })
            ]),
      ),
    );
  }
}
