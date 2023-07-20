import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/models/character.dart';
import '../providers/characters_data.dart';
import '../widgets/character_list_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Character> filteredResults = [];
  late List<Character> allPeople;
  final TextEditingController _searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  Future<void> fetchData() async {
    final charactersProvider =
        Provider.of<CharactersProvider>(context, listen: false);
    await charactersProvider.fetchAllPeople(context).then((_) {
      setState(() {
        allPeople = charactersProvider.people;
        filteredResults = allPeople;
      });
    });
  }

  void filterResults(String query, List<Character> characters) {
    setState(() {
      filteredResults = characters
          .where((character) =>
              character.name.toLowerCase().contains(query.toLowerCase()) ||
              character.homeworld!.name
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  void clearText() {
    setState(() {
      _searchController.clear();
      filteredResults = allPeople;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              onChanged: (query) => filterResults(query, allPeople),
              maxLength: 25,
              decoration: InputDecoration(
                  label: const Text("Search"),
                  suffixIcon: IconButton(
                      onPressed: clearText, icon: const Icon(Icons.clear))),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredResults.length,
              itemBuilder: (c, index) {
                return CharacterListItem(character: filteredResults[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
