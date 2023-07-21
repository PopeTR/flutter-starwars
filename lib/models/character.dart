class Character {
  final String name;
  final String gender;
  final Species? species;
  final PersonStarshipsConnection? starshipConnection;
  final Planet? homeworld;
  final List<String>? starships;

  Character({
    required this.name,
    required this.gender,
    this.species,
    this.starshipConnection,
    this.starships,
    this.homeworld,
  });
// This allows you to print the value of the instance rather than read "Instance of ..."
  @override
  String toString() {
    return 'Character: {name: $name, species: $species, homeworld: $homeworld}';
  }

  factory Character.fromJson(Map<String, dynamic> character) {
    final List<dynamic>? starships =
        character['starshipConnection']['starships'];
    List<String> getStarshipNames() {
      return starships?.map((e) => e['name'] as String).toList() ?? [];
    }

    return Character(
      name: character['name'],
      gender: character['gender'],
      species: character['species'] != null
          ? Species.fromJson(character['species'])
          : null,
      starships: getStarshipNames(),
      homeworld: character['homeworld'] != null
          ? Planet.fromJson(character['homeworld'])
          : null,
    );
  }
}

class Species {
  final String? typename;
  final String? classification;

  Species({
    this.typename,
    this.classification,
  });

  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(
      typename: json['__typename'],
      classification: json['classification'],
    );
  }
}

class PersonStarshipsConnection {
  final List<dynamic>? starships;

  PersonStarshipsConnection({
    this.starships,
  });

  factory PersonStarshipsConnection.fromJson(Map<String, dynamic> json) {
    return PersonStarshipsConnection(
      starships: json['starships'],
    );
  }
}

class Planet {
  final String? typename;
  final String name;

  Planet({
    this.typename,
    required this.name,
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      typename: json['__typename'],
      name: json['name'],
    );
  }
}

// Added in a Query Response class that takes the gql and returns the data in the format we need
class QueryResponse {
  final List<Character> characters;

  QueryResponse({required this.characters});

  factory QueryResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> characterDataList =
        json['allPeople']['people'] as List<dynamic>;
    List<Character> characters = characterDataList.map((characterData) {
      return Character.fromJson(characterData);
    }).toList();

    return QueryResponse(characters: characters);
  }
  // This allows you to print the value of the instance rather than read "Instance of ..."
  @override
  String toString() {
    return 'QueryResponse: {characters: $characters}';
  }
}
