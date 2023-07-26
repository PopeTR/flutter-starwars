import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_wars/models/character.dart';
import 'package:star_wars/providers/characters_data.dart';
import '../widgets/character_list_item.dart';
import '../widgets/gender_filter_botton.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  List<Character> allPeople = [];
  List<Character> filteredResults = [];
  final TextEditingController _searchController = TextEditingController();
  bool isMaleToggle = false;
  bool isFemaleToggle = false;
  bool isOtherToggle = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  Future<void> fetchData() async {
    await ref
        .read(charactersProvider.notifier)
        .fetchAllPeople(context)
        .then((_) {
      setState(() {
        allPeople = ref.read(charactersProvider).people;
        filteredResults = allPeople;
      });
    });
  }

  void filterResults(String query) {
    setState(() {
      filteredResults = allPeople
          .where((character) =>
              character.name.toLowerCase().contains(query.toLowerCase()) ||
              character.homeworld!.name
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              character.gender.toLowerCase().contains(query.toLowerCase()))
          .toList();

      if (isMaleToggle) {
        filteredResults = filterResultsByGender('male', filteredResults);
      } else if (isFemaleToggle) {
        filteredResults = filterResultsByGender('female', filteredResults);
      } else if (isOtherToggle) {
        filteredResults = filterResultsByGender('other', filteredResults);
      }
    });
  }

  List<Character> filterResultsByGender(
      String gender, List<Character> characters) {
    if (gender == 'other') {
      return characters
          .where((character) =>
              character.gender.toLowerCase() != 'male' &&
              character.gender.toLowerCase() != 'female')
          .toList();
    } else {
      return characters
          .where((character) => character.gender.toLowerCase() == gender)
          .toList();
    }
  }

  void filterByGender(String gender) {
    setState(() {
      if (gender == 'male') {
        isMaleToggle = !isMaleToggle;
        if (isMaleToggle) {
          isFemaleToggle = false;
          isOtherToggle = false;
          filteredResults = filterResultsByGender('male', allPeople);
        } else {
          filteredResults = allPeople;
        }
      } else if (gender == 'female') {
        isFemaleToggle = !isFemaleToggle;
        if (isFemaleToggle) {
          isMaleToggle = false;
          isOtherToggle = false;
          filteredResults = filterResultsByGender('female', allPeople);
        } else {
          filteredResults = allPeople;
        }
      } else if (gender == 'other') {
        isOtherToggle = !isOtherToggle;
        if (isOtherToggle) {
          isMaleToggle = false;
          isFemaleToggle = false;
          filteredResults = filterResultsByGender('other', allPeople);
        } else {
          filteredResults = allPeople;
        }
      }
    });
  }

  void clearText() {
    setState(() {
      _searchController.clear();
      isMaleToggle = false;
      isFemaleToggle = false;
      isOtherToggle = false;
      filteredResults = allPeople;
    });
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
              onChanged: filterResults,
              maxLength: 25,
              decoration: InputDecoration(
                label: const Text("Search"),
                suffixIcon: IconButton(
                  onPressed: clearText,
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GenderFilterButton(
                  gender: 'male',
                  label: 'Male',
                  isActive: isMaleToggle,
                  onPressed: () => filterByGender('male'),
                ),
                GenderFilterButton(
                  gender: 'female',
                  label: 'Female',
                  isActive: isFemaleToggle,
                  onPressed: () => filterByGender('female'),
                ),
                GenderFilterButton(
                  gender: 'other',
                  label: 'Other',
                  isActive: isOtherToggle,
                  onPressed: () => filterByGender('other'),
                ),
              ],
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
