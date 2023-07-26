import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:star_wars/models/film.dart';
import '../schemas/get_all_films.dart';

class FilmsNotifier extends StateNotifier<List<Film>> {
  FilmsNotifier() : super([]);

  Future<void> fetchAllFilms(BuildContext context) async {
    final client = GraphQLProvider.of(context).value;
    final QueryResult response = await client
        .query(QueryOptions(document: gql(GetAllFilmsSchema.getFilmsJson)));
    if (response.hasException) {
      print('GraphQL Error: ${response.exception.toString()}');
    } else {
      Map<String, dynamic> data = response.data!;

      FilmQueryResponse queryResponse = FilmQueryResponse.fromJson(data);
      state = queryResponse.films;
    }
  }
}

final filmsProvider = StateNotifierProvider<FilmsNotifier, List<Film>>((ref) {
  return FilmsNotifier();
});
