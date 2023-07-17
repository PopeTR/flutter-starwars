import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/main.dart';
import 'package:star_wars/providers/music_data.dart';
import 'package:star_wars/utils/audio_utils.dart';
import '../providers/films_data.dart';
import '../widgets/carousel.dart';
import '../widgets/character_scroll_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(this.audioPlayer, {super.key});
  final AssetsAudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<MusicProvider>(builder: (context, musicPlayerState, _) {
            return IconButton(
                onPressed: () {
                  musicPlayerState.toggleMute();
                  playAudio(audioPlayer, musicPlayerState.isMuted);
                },
                icon: musicPlayerState.isMuted
                    ? const Icon(
                        Icons.music_off_rounded,
                        color: starWarsYellow,
                      )
                    : const Icon(Icons.music_note_rounded,
                        color: starWarsYellow));
          })
        ],
        title: Text('Star Wars',
            style: Theme.of(context).appBarTheme.titleTextStyle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Consumer<FilmsProvider>(builder: (ctx, allFilms, _) {
              if (allFilms.films.isEmpty) {
                return const CircularProgressIndicator();
              } else {
                return Carousel(allFilms: allFilms.films);
              }
            }),
            const CharacterScrollList(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(color: starWarsYellow),
        selectedItemColor: starWarsYellow,
        unselectedItemColor: Color.fromARGB(255, 155, 137, 33),
        backgroundColor: Color.fromARGB(184, 50, 50, 50),
        selectedIconTheme: IconThemeData(color: starWarsYellow),
        unselectedIconTheme:
            IconThemeData(color: Color.fromARGB(255, 155, 137, 33)),
        unselectedLabelStyle: const TextStyle(color: starWarsYellow),
        onTap: (value) {},
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Characters',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
