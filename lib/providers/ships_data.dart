import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_wars/models/ship.dart';
import 'package:star_wars/repositories/ship_repository.dart';

final shipRepositoryProvider = Provider<ShipRepository>((ref) {
  return ShipRepository();
});

class ShipsNotifier extends StateNotifier<AsyncValue<List<Ship>>> {
  final ShipRepository _repository;
  List<Ship> _allShips = [];
  int _currentPage = 1;
  final int _pageCount = 10;
  bool _isLoadingMore = false;

  ShipsNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> getShips(BuildContext context) async {
    try {
      final ships = await _repository.fetchShips(page: _currentPage);
      _allShips = ships;
      state = AsyncValue.data(ships);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> loadMoreShips(BuildContext context) async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;

    try {
      if (_allShips.length < _currentPage * _pageCount) {
        return;
      }
      final moreShips = await _repository.fetchShips(page: ++_currentPage);
      _allShips.addAll(moreShips);
      state = AsyncValue.data(_allShips);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    } finally {
      _isLoadingMore = false; // Reset loading state
    }
  }
}

final shipsProvider =
    StateNotifierProvider<ShipsNotifier, AsyncValue<List<Ship>>>((ref) {
  final repository = ref.watch(shipRepositoryProvider);
  return ShipsNotifier(repository);
});
