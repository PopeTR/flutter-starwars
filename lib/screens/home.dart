import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/films_data.dart';
import '../widgets/carousel.dart';
import '../widgets/character_scroll_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Star Wars',
            style: Theme.of(context).appBarTheme.titleTextStyle),
      ),
      body: Column(
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
    );
  }
}
