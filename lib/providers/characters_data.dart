import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:star_wars/models/character.dart';
import '../schemas/get_all_people.dart';

class CharactersProvider extends ChangeNotifier {
  List<Character> _people = [];
  int _currentPeople = 0;
  int _totalPeople = 0;
  final int _pageCount = 10;
  String? afterCursor;

  List<Character> get people => _people;

  Future<void> fetchPeople(BuildContext context) async {
    final client = GraphQLProvider.of(context).value;
    final QueryResult response = await client.query(
        QueryOptions(document: gql(GetAllPeopleSchema.getPeople(_pageCount))));

    if (response.hasException) {
      print('GraphQL Error: ${response.exception.toString()}');
    } else {
      Map<String, dynamic> data = response.data!;

      QueryResponse queryResponse = QueryResponse.fromJson(data);
      _people = queryResponse.characters;
      _currentPeople = _pageCount;
      _totalPeople = response.data?['allPeople']['totalCount'] ?? _pageCount;
      notifyListeners();
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
      _people = queryResponse.characters;
      _totalPeople = response.data?['allPeople']['totalCount'] ?? _pageCount;
      notifyListeners();
    }
  }

  Future<void> loadMorePeople(BuildContext context) async {
    if (_currentPeople < _totalPeople) {
      final client = GraphQLProvider.of(context).value;
      final response = await client.query(QueryOptions(
        document:
            gql(GetAllPeopleSchema.getPeople(_currentPeople + _pageCount)),
        variables: {'page': _currentPeople + _pageCount},
      ));

      if (response.hasException) {
        print('GraphQL Error: ${response.exception.toString()}');
      } else {
        Map<String, dynamic> data = response.data!;

        QueryResponse queryResponse = QueryResponse.fromJson(data);

        _people.addAll(
            //  Had to do this as SWAPI GQL doesnt have the ability to request sublists. So done manually in Provider
            queryResponse.characters.sublist(_currentPeople));
        _currentPeople += _pageCount;
        notifyListeners();
      }
    }
  }
}
