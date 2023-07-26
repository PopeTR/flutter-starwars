import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_wars/main.dart';
import '../providers/characters_data.dart';
import '../providers/films_data.dart';
import '../widgets/carousel.dart';
import '../widgets/character_scroll_list.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(charactersProvider.notifier).fetchPeople(context);
    final allFilms = ref.read(filmsProvider);

    final width = MediaQuery.of(context).size.width;

    final content = [
      if (allFilms.isEmpty)
        const CircularProgressIndicator()
      else
        width < 600
            ? Flexible(child: Carousel(allFilms: allFilms))
            : Flexible(
                flex: 2,
                child: Carousel(allFilms: allFilms),
              ),
      const Divider(
        height: 1,
        color: starWarsYellow,
        endIndent: 16,
        indent: 16,
      ),
      const Flexible(
        flex: 2,
        child: CharacterScrollList(),
      ),
    ];

    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        width > 600
            ? Expanded(
                child: Row(
                  children: content,
                ),
              )
            : Expanded(
                child: Column(
                  children: content,
                ),
              ),
      ])),
    );
  }
}
