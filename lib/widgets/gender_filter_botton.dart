import 'package:flutter/material.dart';

import '../main.dart';

class GenderFilterButton extends StatelessWidget {
  final String gender;
  final String label;
  final bool isActive;
  final Function() onPressed;

  const GenderFilterButton({
    super.key,
    required this.gender,
    required this.label,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed) || isActive) {
              return starWarsYellow;
            }
            return transparentStarWarsYellow;
          },
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
