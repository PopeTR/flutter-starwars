import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:star_wars/models/ship.dart';

class ShipRepository {
  final String apiUrl = 'https://swapi.dev/api/starships';
  Future<List<Ship>> fetchShips({required int page}) async {
    final response = await http.get(Uri.parse('$apiUrl?page=$page'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> shipsData = jsonData['results'];
      return shipsData.map((json) => Ship.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Ships');
    }
  }
}