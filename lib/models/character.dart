class Character {
  final String name;
  final Species? species;
  final PersonStarshipsConnection starshipConnection;
  final Planet? homeworld;

  Character({
    required this.name,
    this.species,
    required this.starshipConnection,
    this.homeworld,
  });

  factory Character.fromJson(Map<String, dynamic> character) {
    return Character(
      name: character['name'],
      species: character['species'] != null
          ? Species.fromJson(character['species'])
          : null,
      starshipConnection:
          PersonStarshipsConnection.fromJson(character['starshipConnection']),
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
  final String? name;

  Planet({
    this.typename,
    this.name,
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      typename: json['__typename'],
      name: json['name'],
    );
  }
}
