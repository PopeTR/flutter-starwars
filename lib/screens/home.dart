import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/main.dart';
import '../providers/characters_data.dart';
import '../providers/films_data.dart';
import '../widgets/carousel.dart';
import '../widgets/character_scroll_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<CharactersProvider>(context, listen: false)
        .fetchPeople(context);

    final width = MediaQuery.of(context).size.width;

    final content = [
      Consumer<FilmsProvider>(builder: (ctx, allFilms, _) {
        if (allFilms.films.isEmpty) {
          return const CircularProgressIndicator();
        } else {
          if (width < 600) {
            return Flexible(child: Carousel(allFilms: allFilms.films));
          } else {
            return Flexible(
              flex: 2,
              child: Carousel(allFilms: allFilms.films),
            );
          }
        }
      }),
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
