import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../schemas/get_all_films.dart';

class FilmsProvider extends ChangeNotifier {
  // Define a private list to store the fetched people
  List<dynamic> _films = [];

  // Getter for the people list
  List<dynamic> get films => _films;

  // Fetch allPeople from SWAPI
  Future<void> fetchAllFilms(BuildContext context) async {
    final client = GraphQLProvider.of(context).value;
    final result = await client
        .query(QueryOptions(document: gql(GetAllFilmsSchema.getFilmsJson)));

    if (result.hasException) {
      print('GraphQL Error: ${result.exception.toString()}');
    } else {
      _films = result.data?['allFilms']['films'] ?? [];
      notifyListeners();
    }
  }
}
