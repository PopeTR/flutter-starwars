import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ship.dart';
// import '../providers/favourites_data.dart';
// import '../screens/details.dart';

class ShipListItem extends StatelessWidget {
  const ShipListItem({required this.ship, super.key});
  final Ship ship;
  @override
  Widget build(BuildContext context) {
    return  ListTile(
        title: Text(ship.name),
        minVerticalPadding: 0,
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        subtitle: Text(ship.manufacturer),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // trailing: IconButton(
        //   onPressed: () {
        //     ref
        //         .read(favouritesProvider.notifier)
        //         .toggleFavouriteCharacter(character);
        //   },
        //   icon: isFavourite
        //       ? const Icon(Icons.favorite)
        //       : const Icon(Icons.favorite_border),
        // ),

    );
  }
}
