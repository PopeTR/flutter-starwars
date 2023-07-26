import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:star_wars/models/character.dart';
import '../schemas/get_all_people.dart';

class CharactersNotifier extends StateNotifier<CharactersState> {
  CharactersNotifier()
      : super(CharactersState(people: [], currentPeople: 0, totalPeople: 0));

  Future<void> fetchPeople(BuildContext context) async {
    final client = GraphQLProvider.of(context).value;
    final QueryResult response = await client.query(QueryOptions(
        document: gql(GetAllPeopleSchema.getPeople(state.pageCount))));

    if (response.hasException) {
      print('GraphQL Error: ${response.exception.toString()}');
    } else {
      Map<String, dynamic> data = response.data!;

      QueryResponse queryResponse = QueryResponse.fromJson(data);
      state = state.copyWith(
        people: queryResponse.characters,
        currentPeople: state.pageCount,
        totalPeople:
            response.data?['allPeople']['totalCount'] ?? state.pageCount,
      );
    }
  }

  Future<void> fetchAllPeople(BuildContext context) async {
    final client = GraphQLProvider.of(context).value;
    final QueryResult response = await client
        .query(QueryOptions(document: gql(GetAllPeopleSchema.getPeople(null))));

    if (response.hasException) {
      print('GraphQL Error: ${response.exception.toString()}');
    } else {
      Map<String, dynamic> data = response.data!;

      QueryResponse queryResponse = QueryResponse.fromJson(data);
      state = state.copyWith(
        people: queryResponse.characters,
        totalPeople:
            response.data?['allPeople']['totalCount'] ?? state.pageCount,
      );
    }
  }

  Future<void> loadMorePeople(BuildContext context) async {
    if (state.currentPeople < state.totalPeople) {
      final client = GraphQLProvider.of(context).value;
      final response = await client.query(QueryOptions(
        document: gql(GetAllPeopleSchema.getPeople(
            state.currentPeople + state.pageCount)),
        variables: {'page': state.currentPeople + state.pageCount},
      ));

      if (response.hasException) {
        print('GraphQL Error: ${response.exception.toString()}');
      } else {
        Map<String, dynamic> data = response.data!;

        QueryResponse queryResponse = QueryResponse.fromJson(data);
        state = state.copyWith(
          people: state.people
            ..addAll(queryResponse.characters.sublist(state.currentPeople)),
          currentPeople: state.currentPeople + state.pageCount,
        );
      }
    }
  }
}

final charactersProvider =
    StateNotifierProvider<CharactersNotifier, CharactersState>((ref) {
  return CharactersNotifier();
});

class CharactersState {
  List<Character> people;
  int currentPeople;
  int totalPeople;
  final int pageCount = 10;
  String? afterCursor;

  CharactersState({
    required this.people,
    required this.currentPeople,
    required this.totalPeople,
    this.afterCursor,
  });

  CharactersState copyWith({
    List<Character>? people,
    int? currentPeople,
    int? totalPeople,
    String? afterCursor,
  }) {
    return CharactersState(
      people: people ?? this.people,
      currentPeople: currentPeople ?? this.currentPeople,
      totalPeople: totalPeople ?? this.totalPeople,
      afterCursor: afterCursor ?? this.afterCursor,
    );
  }
}
