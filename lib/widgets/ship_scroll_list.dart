import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_wars/models/ship.dart';
import 'package:star_wars/widgets/ship_list_item.dart';
import '../providers/ships_data.dart';

class ShipScrollList extends ConsumerStatefulWidget {
  final List<Ship> ships;
  const ShipScrollList({super.key, required this.ships});

  @override
  ConsumerState<ShipScrollList> createState() => _ShipScrollListState();
}

class _ShipScrollListState extends ConsumerState<ShipScrollList> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_controller.position.atEdge) {
      bool isBottom = _controller.position.pixels == _controller.position.maxScrollExtent;
      if (isBottom) {
        ref.read(shipsProvider.notifier).loadMoreShips(context);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      itemCount: widget.ships.length,
      itemBuilder: (ctx, index) {
        final ship = widget.ships[index];
        return ShipListItem(ship: ship);
      },
    );
  }
}
