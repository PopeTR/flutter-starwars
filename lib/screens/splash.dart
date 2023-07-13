import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<FilmsProvider>(context, listen: false).fetchAllFilms(context);
    Provider.of<CharactersProvider>(context, listen: false)
        .fetchPeople(context);

    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/Star_Wars_Logo.png'),
            Lottie.asset(
              'assets/images/yoda.json',
              repeat: true,
              reverse: true,
            ),
          ]),
    );
  }
}
