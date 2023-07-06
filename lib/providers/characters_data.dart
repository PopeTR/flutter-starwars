import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../schemas/get_all_people.dart';

class CharactersProvider extends ChangeNotifier {
  // Define a private list to store the fetched people
  List<dynamic> _people = [];

  // Getter for the people list
  List<dynamic> get people => _people;

  // Fetch allPeople from SWAPI
  Future<void> fetchAllPeople(BuildContext context) async {
    final client = GraphQLProvider.of(context).value;
    final result = await client
        .query(QueryOptions(document: gql(GetAllPeopleSchema.getTaskJson)));

    if (result.hasException) {
      print('GraphQL Error: ${result.exception.toString()}');
    } else {
      _people = result.data?['allPeople']['people'] ?? [];
      notifyListeners();
    }
  }
}
