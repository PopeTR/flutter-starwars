import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ships_data.dart';
import '../widgets/ship_scroll_list.dart';

class ShipsScreen extends ConsumerStatefulWidget {
  const ShipsScreen({super.key});
  @override
  ShipsScreenState createState() => ShipsScreenState();
}

class ShipsScreenState extends ConsumerState<ShipsScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(shipsProvider.notifier).getShips(context);
  }

  @override
  Widget build(BuildContext context) {
    final allShipsState = ref.watch(shipsProvider);

    return Scaffold(
        body: SafeArea(
            child: allShipsState.when(
      data: (ships) {
        if (ships.isEmpty) {
          return const Center(child: Text('No ships available.'));
        }
        return ShipScrollList(ships: ships);
      },
      error: (error, stack) => Center(child: Text('Error: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    )));
  }
}
