class Vehicle {
  final String name;
  final List<dynamic> films;
  List<String> filmsNames;

  Vehicle({required this.name, required this.films, this.filmsNames = const []});

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(name: json['name'], films: json['films']);
  }
}
