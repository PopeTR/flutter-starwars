import 'package:dio/dio.dart';
import 'package:star_wars/models/vehicle.dart';

class VehiclesRepository {
  final String baseApiUrl = 'https://swapi.dev/api';
  final Dio dio;

  VehiclesRepository({Dio? dio}) : dio = dio ?? Dio();

  Future<List<Vehicle>> fetchVehicles() async {
    final response = await dio.get('$baseApiUrl/vehicles');
    if (response.statusCode == 200) {
      final List<dynamic> shipsData = response.data['results'];
      return shipsData.map((json) => Vehicle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Vehicles: ${response.statusCode}');
    }
  }

  // Future<List<Vehicle>> fetchFilmNames() async {
  //   final response = await dio.get('$baseApiUrl/films');
  //   if (response.statusCode == 200) {
  //     final List<dynamic> shipsData = response.data['results'];
  //     return shipsData.map((json) => Vehicle.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load Vehicles: ${response.statusCode}');
  //   }
  // }
}
