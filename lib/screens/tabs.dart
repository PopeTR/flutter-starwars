import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_wars/providers/vehicles_data.dart';
import 'package:star_wars/screens/home.dart';
import 'package:star_wars/screens/search.dart';
import 'package:star_wars/screens/ships.dart';
import 'package:star_wars/screens/vehicles.dart';
import '../main.dart';
import '../providers/favourites_data.dart';
import '../providers/music_data.dart';
import '../providers/ships_data.dart';
import '../extensions/audio_utils.dart';
import 'favourites.dart';

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
    ref.watch(favouritesProvider);

    Widget activePage = const HomeScreen();
    var activePageTitle = 'Characters';

    if (_selectedPageIndex == 1) {
      final favouriteCharacters = ref.watch(favouritesProvider);
      activePage = FavouritesScreen(characters: favouriteCharacters);
      activePageTitle = 'Favourites';
    }

    if (_selectedPageIndex == 2) {
      // final favouriteCharacters = ref.watch(favouritesProvider);
      activePage = const SearchScreen();
      activePageTitle = 'Search';
    }

    if (_selectedPageIndex == 3) {
      activePage = const ShipsScreen();
      activePageTitle = 'Ships';
    }

    if (_selectedPageIndex == 4) {
      activePage = const VehiclesScreen();
      activePageTitle = 'Vehicles';
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              musicalProvider.toggleMute();
              context.playAudio(widget.audioPlayer, !isMuted);
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
          BottomNavigationBarItem(
            icon: Icon(
              Icons.directions_boat,
            ),
            label: 'Ships',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.car_rental,
            ),
            label: 'Vehicles',
          ),
        ],
      ),
    );
  }
}
