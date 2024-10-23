import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_wars/models/film.dart';
import 'package:star_wars/models/vehicle.dart';
import 'package:star_wars/repositories/films_repository.dart';
import 'package:star_wars/repositories/vehicles_repository.dart';

final vehicleRepositoryProvider = Provider<VehiclesRepository>((ref) {
  return VehiclesRepository();
});

final filmRepositoryProvider = Provider<FilmsRepository>((ref) {
  return FilmsRepository();
});

class VehiclesNotifier extends StateNotifier<AsyncValue<List<Vehicle>>> {
  final VehiclesRepository _repository;
  final FilmsRepository _filmsRepository;

  List<Vehicle> _allVehicles = [];
  List<Film> _allFilms = [];

  VehiclesNotifier(this._repository, this._filmsRepository)
      : super(const AsyncValue.loading());

  Future<void> getVehicles(BuildContext context) async {
    try {
      final vehicles = await _repository.fetchVehicles();
      final films = await _filmsRepository.fetchFilms();
      _allVehicles = vehicles;
      _allFilms = films;
      final filmMap = {for (var film in films) "${film.episodeId}": film.title};

      for (var vehicle in vehicles) {
        vehicle.filmsNames = vehicle.films
            .map((url) {
              final splitUrl = url.split('/')..removeLast();
              final filmId = splitUrl.last;
              return filmId;
            })
            .map((id) => filmMap[id] ?? 'Unknown') 
            .toList();
      }

      state = AsyncValue.data(vehicles);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final vehiclesProvider =
    StateNotifierProvider<VehiclesNotifier, AsyncValue<List<Vehicle>>>((ref) {
  final repository = ref.watch(vehicleRepositoryProvider);
  final filmsRepository = ref.watch(filmRepositoryProvider);
  return VehiclesNotifier(repository, filmsRepository);
});
