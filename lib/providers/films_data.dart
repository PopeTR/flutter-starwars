import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:star_wars/models/film.dart';
import '../schemas/get_all_films.dart';

class FilmsProvider extends ChangeNotifier {
  List<Film> _films = [];

  List<Film> get films => _films;

  Future<void> fetchAllFilms(BuildContext context) async {
    final client = GraphQLProvider.of(context).value;
    final QueryResult response = await client
        .query(QueryOptions(document: gql(GetAllFilmsSchema.getFilmsJson)));
    print(response);
    if (response.hasException) {
      print('GraphQL Error: ${response.exception.toString()}');
    } else {
      Map<String, dynamic> data = response.data!;

      FilmQueryResponse queryResponse = FilmQueryResponse.fromJson(data);
      _films = queryResponse.films;
      notifyListeners();
    }
  }
}
