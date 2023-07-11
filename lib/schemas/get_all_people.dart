class GetAllPeopleSchema {
  static String getPeople(int first) {
    return """ query {
  allPeople(first: $first) {
    totalCount
    people {
      name
      species {
        classification
      }
      starshipConnection {
        starships {
          name
        }
      }
      homeworld {
        name
      }
    }
  }
}
""";
  }
}
