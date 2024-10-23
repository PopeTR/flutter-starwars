import 'package:dio/dio.dart';
import 'package:star_wars/models/film.dart';

class FilmsRepository {
  final dio = Dio();
  final apiUrl = 'https://swapi.dev/api/films';

  Future<List<Film>> fetchFilms() async {
    try {
      final response = await dio.get(apiUrl);
      final List<dynamic> filmsData = response.data['results'];
      return filmsData.map((json) => Film.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
        throw Exception('Failed to load Films: ${e.response?.statusCode}');
      } else {
        print(e.requestOptions);
        print(e.message);
        throw Exception('Failed to load Films: ${e.response?.statusCode}');
      }
    }
  }
}
