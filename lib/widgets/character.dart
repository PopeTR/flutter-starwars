import 'package:flutter/material.dart';

class Character extends StatelessWidget {
  const Character({super.key, required this.characterName});
  final String characterName;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(characterName),
    );
  }
}
