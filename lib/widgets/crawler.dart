import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:star_wars/main.dart';

class Crawler extends StatefulWidget {
  const Crawler({super.key, required this.text});
  final crawlDuration = const Duration(seconds: 20);
  final String text;
  @override
  createState() => _CrawlerState();
}

class _CrawlerState extends State<Crawler> {
  final _scrollController = ScrollController();
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playMusic() async {
    try {
      int result = await audioPlayer.play(
          'https://s.cdpn.io/1202/Star_Wars_original_opening_crawl_1977.mp3');
      if (result == 1) {
        // success
        print('Music started playing');
      } else {
        // error
        print('Error playing music');
      }
    } catch (e) {
      // error
      print('Error loading music: $e');
    }
  }

  @override
  void initState() {
    playMusic();
    Future.delayed(
        const Duration(milliseconds: 1000),
        () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: widget.crawlDuration,
            curve: Curves.linear));

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Future<void> stopMusic() async {
      int result = await audioPlayer.stop();
      if (result == 1) {
        // success
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SuperSize(
      height: 1279,
      child: ListView(
        controller: _scrollController,
        children: [
          SizedBox(height: height),
          Text(
            widget.text.trim(),
            style: const TextStyle(
              color: starWarsYellow,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height),
        ],
      ),
    );
  }
}

class SuperSize extends StatelessWidget {
  const SuperSize({super.key, required this.child, this.height = 1000});
  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      minHeight: height,
      maxHeight: height,
      child: child,
    );
  }
}
