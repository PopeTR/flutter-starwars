class Film {
  final String? title;
  final dynamic releaseDate;

  Film({this.title, this.releaseDate});

  @override
  String toString() {
    return 'Film: {title: $title, releaseDate: $releaseDate}';
  }

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(releaseDate: json['releaseData'], title: json['title']);
  }
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
