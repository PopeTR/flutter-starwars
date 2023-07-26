import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_wars/widgets/character_list_item.dart';
import '../providers/characters_data.dart';

class CharacterScrollList extends ConsumerStatefulWidget {
  const CharacterScrollList({super.key});

  @override
  ConsumerState<CharacterScrollList> createState() =>
      _CharacterScrollListState();
}

class _CharacterScrollListState extends ConsumerState<CharacterScrollList> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        ref.read(charactersProvider.notifier).loadMorePeople(context);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allCharacters = ref.watch(charactersProvider).people;

    return ListView.builder(
      itemCount: allCharacters.length + 1,
      controller: controller,
      itemBuilder: (ctx, index) {
        if (index < allCharacters.length) {
          final character = allCharacters[index];
          return CharacterListItem(character: character);
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
