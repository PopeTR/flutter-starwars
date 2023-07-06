import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/characters_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final allCharacters =
        Provider.of<CharactersProvider>(context, listen: false)
            .fetchAllPeople(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Star Wars Characters'),
      ),
      body: Consumer<CharactersProvider>(builder: (ctx, allCharacters, _) {
        if (allCharacters.people.isEmpty) {
          return const CircularProgressIndicator();
        } else {
          return ListView.builder(
            itemCount: 10,
            itemBuilder: (ctx, index) {
              final character = allCharacters.people[index];
              return ListTile(
                title: Text(character['name']),
                subtitle: Text(character['homeworld']['name']),
              );
            },
          );
        }
      }),
    );
  }
}
