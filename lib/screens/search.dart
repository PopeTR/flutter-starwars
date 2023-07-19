import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/characters_data.dart';
import '../widgets/character_list_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> filteredResults = [];
  final TextEditingController _searchController = TextEditingController();
  void filterResults(String query, List<dynamic> characters) {
    setState(() {
      filteredResults = characters
          .where((character) =>
              character['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CharactersProvider>(context, listen: false)
        .fetchAllPeople(context);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              onChanged: (query) => filterResults(
                  query,
                  Provider.of<CharactersProvider>(context, listen: false)
                      .people),
              maxLength: 25,
              decoration: const InputDecoration(label: Text("Search")),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(child: Consumer<CharactersProvider>(
            builder: (ctx, allCharacters, _) {
              return ListView.builder(
                itemCount: allCharacters.people.length,
                itemBuilder: (c, index) {
                  return CharacterListItem(
                      character: allCharacters.people[index]);
                },
              );
            },
          )),
        ],
      ),
    );
  }
}
