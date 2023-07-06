class GetAllPeopleSchema {
  static String getTaskJson = """ query {
  allPeople {
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
