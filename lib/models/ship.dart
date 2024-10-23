class Ship {
  final String name;
  final String manufacturer;
  final String crew;
  final String passengers;

  Ship(
      {required this.name,
      required this.manufacturer,
      required this.crew,
      required this.passengers});

  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'manufacturer': manufacturer,
  //     'crew': crew,
  //     'passengers': passengers
  //   };
  // }

  factory Ship.fromJson(Map<String, dynamic> json) {
    return Ship(
        name: json['name'],
        manufacturer: json['manufacturer'],
        crew: json['crew'],
        passengers: json['passengers']);
  }
}
