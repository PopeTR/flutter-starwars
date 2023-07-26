import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_wars/screens/home.dart';
import 'package:star_wars/screens/search.dart';
import '../main.dart';
import '../providers/music_data.dart';
import '../utils/audio_utils.dart';

class TabsScreen extends ConsumerStatefulWidget {
  final AssetsAudioPlayer audioPlayer;

  const TabsScreen(
    this.audioPlayer, {
    super.key,
  });
  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = ref.watch(musicProvider);
    final musicalProvider = ref.read(musicProvider.notifier);

    Widget activePage = const HomeScreen();
    var activePageTitle = 'Characters';

    if (_selectedPageIndex == 1) {
      // final favouriteMeals = ref.watch(favouritesProvider);
      // activePage = FavouritesScreen();
      activePageTitle = 'Favourites';
    }

    if (_selectedPageIndex == 2) {
      // final favouriteMeals = ref.watch(CharactersProvider());
      activePage = const SearchScreen();
      activePageTitle = 'Search';
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              musicalProvider.toggleMute();
              playAudio(widget.audioPlayer, !isMuted);
            },
            icon: isMuted
                ? const Icon(
                    Icons.music_off_rounded,
                    color: starWarsYellow,
                  )
                : const Icon(Icons.music_note_rounded, color: starWarsYellow),
          ),
        ],
        title: Text(activePageTitle,
            style: Theme.of(context).appBarTheme.titleTextStyle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
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
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
