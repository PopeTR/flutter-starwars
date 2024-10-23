import 'package:json_annotation/json_annotation.dart';

part 'film.g.dart';

@JsonSerializable()
class Film {
  final String title;

  @JsonKey(name: 'release_date') // Specify the JSON key
  final String? releaseDate; // Make nullable if it can be null

  @JsonKey(name: 'opening_crawl') // Specify the JSON key
  final String? openingCrawl; // Make nullable if it can be null

  @JsonKey(name: 'episode_id') // Specify the JSON key
  final num? episodeId;

  Film({
    required this.title,
    this.releaseDate,
    this.openingCrawl,
    this.episodeId,
  });

  @override
  String toString() {
    return 'Film: {title: $title}';
  }

  // Factory constructor for creating a Film instance from a map
  factory Film.fromJson(Map<String, dynamic> json) => _$FilmFromJson(json);

  // Method for converting a Film instance to a map
  Map<String, dynamic> toJson() => _$FilmToJson(this);
}

class FilmQueryResponse {
  final List<Film> films;

  FilmQueryResponse({required this.films});

  factory FilmQueryResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> filmDataList = json['allFilms']['films'] as List<dynamic>;
    List<Film> films = filmDataList.map((filmData) {
      return Film.fromJson(filmData);
    }).toList();
    return FilmQueryResponse(films: films);
  }
  @override
  String toString() {
    return 'QueryResponse: {films: $films}';
  }
}
