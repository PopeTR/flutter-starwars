class GetAllFilmsSchema {
  static String getFilmsJson = """
query {
  allFilms {
    films {
      title
      releaseDate
    }
  }
} """;
}
