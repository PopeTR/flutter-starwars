import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_wars/providers/vehicles_data.dart';

class VehiclesScreen extends ConsumerWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(vehiclesProvider.notifier).getVehicles(context);
    final allVehiclesState = ref.watch(vehiclesProvider);
    return Scaffold(
        body: SafeArea(
            child: allVehiclesState.when(
      data: (vehicles) {
        if (vehicles.isEmpty) {
          return const Center(child: Text('No vehicles available.'));
        }
        return ListView.builder(
          itemCount: vehicles.length,
          itemBuilder: (ctx, index) {
            final vehicle = vehicles[index];
            return ListTile(
              title: Text(vehicle.name),
              minVerticalPadding: 0,
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              subtitle: Text(vehicle.filmsNames.join(', ')),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          },
        );
      },
      error: (error, stack) => Center(child: Text('Error: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    )));
  }
}
