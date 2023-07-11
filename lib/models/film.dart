class Film {
  final String? title;
  final String? releaseDate;

  Film({this.title, this.releaseDate});

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(releaseDate: json['releaseData'], title: json['title']);
  }
}
