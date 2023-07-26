class GetAllPeopleSchema {
  static String getPeople(int? first) {
    final bool hasFirst = first != null;

    return """ query {
  allPeople${hasFirst ? '(first: $first)' : ''} {
    totalCount
    people {
      id
      name
      gender
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
