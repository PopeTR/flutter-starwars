import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key, required this.character});
  final Character character;
  @override
  Widget build(BuildContext context) {
    final List<dynamic> starships =
        character.starshipConnection.starships ?? [];
    final List<String> names = [];

    void addStarshipNamesToString() {
      if (starships.isNotEmpty) {
        for (var starship in starships) {
          names.add(starship['name']);
        }
      }
    }

    addStarshipNamesToString();

    return Scaffold(
        appBar: AppBar(title: const Text('Character')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/Star_Wars_Logo.png',
                // width: 300,
              ),
              Text(character.name,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 255, 225, 0),
                      )),
              Text('World: ${character.homeworld!.name ?? ''}'),
              Text(
                  'Species: ${character.species != null ? character.species!.classification!.toUpperCase() : 'NA'}'),
              Row(
                children: [
                  ...names.map(
                    (e) => Container(
                      margin: EdgeInsets.only(right: 8),
                      child: Chip(
                        label: Text(e),
                        backgroundColor: Colors.grey.shade500,
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .fontSize),
                        labelPadding: const EdgeInsets.all(0),
                        // padding: const EdgeInsets.all(0),
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  ),
                ],
              )
              // Text(
              //     'Starships: ${character.starshipConnection!.starships != null ?  : 'NA'}')
            ],
          ),
        ));
  }
}
