import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../schemas/get_all_people.dart';

class CharactersProvider extends ChangeNotifier {
  List<dynamic> _people = [];
  int _currentPeople = 0;
  int _totalPeople = 0;
  final int _pageCount = 10;
  String? afterCursor;

  List<dynamic> get people => _people;

  Future<void> fetchPeople(BuildContext context) async {
    final client = GraphQLProvider.of(context).value;
    final result = await client.query(
        QueryOptions(document: gql(GetAllPeopleSchema.getPeople(_pageCount))));

    if (result.hasException) {
      print('GraphQL Error: ${result.exception.toString()}');
    } else {
      _people = result.data?['allPeople']['people'] ?? [];
      _currentPeople = _pageCount;
      _totalPeople = result.data?['allPeople']['totalCount'] ?? _pageCount;
      notifyListeners();
    }
  }

  Future<void> loadMorePeople(BuildContext context) async {
    if (_currentPeople < _totalPeople) {
      final client = GraphQLProvider.of(context).value;
      final result = await client.query(QueryOptions(
        document:
            gql(GetAllPeopleSchema.getPeople(_currentPeople + _pageCount)),
        variables: {'page': _currentPeople + _pageCount},
      ));

      if (result.hasException) {
        print('GraphQL Error: ${result.exception.toString()}');
      } else {
        _people.addAll(
            //  Had to do this as SWAPI GQL doesnt have the ability to request sublists. So done manually in Provider
            result.data?['allPeople']['people'].sublist(_currentPeople) ?? []);
        _currentPeople += _pageCount;
        notifyListeners();
      }
    }
  }
}
