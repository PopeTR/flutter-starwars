import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/characters_data.dart';
import '../screens/character_details.dart';

class CharacterScrollList extends StatefulWidget {
  const CharacterScrollList({super.key});

  @override
  State<CharacterScrollList> createState() => _CharacterScrollListState();
}

class _CharacterScrollListState extends State<CharacterScrollList> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        Provider.of<CharactersProvider>(context, listen: false)
            .loadMorePeople(context);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CharactersProvider>(builder: (c, allCharacters, _) {
      if (allCharacters.people.isEmpty) {
        return const CircularProgressIndicator();
      } else {
        return Expanded(
          child: ListView.builder(
            itemCount: allCharacters.people.length + 1,
            controller: controller,
            itemBuilder: (ctx, index) {
              if (index < allCharacters.people.length) {
                final character = allCharacters.people[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) =>
                            CharacterDetailsScreen(character: character),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(character.name),
                    subtitle: Text(character.homeworld.name),
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        );
      }
    });
  }
}
