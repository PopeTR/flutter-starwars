import 'package:flutter/material.dart';
import '../main.dart';
import '../models/character.dart';
import '../models/film.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen(
      {super.key,
      this.character,
      this.film,
      this.image,
      required this.isCharacterPage});
  final Character? character;
  final Film? film;
  final bool isCharacterPage;
  final String? image;

  @override
  Widget build(BuildContext context) {
    Widget content = const Text('No Data');

    if (!isCharacterPage) {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: film!.title,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: starWarsYellow, width: 2),
              ),
              child: image != null
                  ? Image.network(
                      image!,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    )
                  : Image.asset(
                      'assets/images/Star_Wars_Logo.png',
                    ),
            ),
          ),
          const SizedBox(height: 16),
          Text(film!.title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 225, 0),
                  )),
          Text(film!.releaseDate),
          const SizedBox(height: 8),
          Text(film!.openingCrawl),
        ],
      );
    }

    if (isCharacterPage) {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: Image.asset(
              'assets/images/Star_Wars_Logo.png',
            ),
          ),
          const SizedBox(height: 16),
          Text(character!.name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 225, 0),
                  )),
          Text('World: ${character!.homeworld!.name ?? ''}'),
          Text(
              'Species: ${character!.species != null ? character!.species!.classification!.toUpperCase() : 'NA'}'),
          Row(
            children: [
              ...character!.starships!.map(
                (e) => Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Chip(
                    label: Text(e),
                    backgroundColor: Colors.grey.shade500,
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize:
                            Theme.of(context).textTheme.labelSmall!.fontSize),
                    labelPadding: const EdgeInsets.all(0),
                    // padding: const EdgeInsets.all(0),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(isCharacterPage ? 'Character' : 'Film')),
      body: Padding(padding: const EdgeInsets.all(16.0), child: content),
    );
  }
}
