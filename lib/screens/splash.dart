import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/screens/home.dart';

import '../providers/characters_data.dart';
import '../providers/films_data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => const HomeScreen()));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<FilmsProvider>(context, listen: false).fetchAllFilms(context);
    Provider.of<CharactersProvider>(context, listen: false)
        .fetchPeople(context);
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/Star_Wars_Logo.png'),
      ),
    );
  }
}
