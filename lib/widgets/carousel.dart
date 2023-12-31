import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:star_wars/data/films.dart';
import '../main.dart';
import '../models/film.dart';
import 'package:transparent_image/transparent_image.dart';

import '../screens/details.dart';

class Carousel extends StatelessWidget {
  Carousel({super.key, required this.allFilms});

  final List<Film> allFilms;
  final CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    bool shouldShowManualButtons = MediaQuery.of(context).size.width < 600;
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 30),
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 2.0,
                initialPage: 2,
              ),
              items: allFilms.map((film) {
                var index = allFilms.indexOf(film);
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => DetailsScreen(
                              film: film,
                              isCharacterPage: false,
                              image: filmImages[index].url,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: film.title,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 10.0),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: starWarsYellow, width: 2),
                              boxShadow: [
                                BoxShadow(
                                    color: starWarsYellow.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 5)
                              ]),
                          child: Stack(
                            children: [
                              FadeInImage(
                                placeholder: MemoryImage(kTransparentImage),
                                image: NetworkImage(filmImages[index].url),
                                fit: BoxFit.cover,
                                height: double.infinity,
                                width: double.infinity,
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3)),
                                child: Center(
                                  child: ExcludeSemantics(
                                    child: Text(
                                      film.title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .fontWeight),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Visibility(
            visible: shouldShowManualButtons,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => buttonCarouselController.previousPage(),
                  child:
                      const Text('←', style: TextStyle(color: starWarsYellow)),
                ),
                TextButton(
                  onPressed: () => buttonCarouselController.nextPage(),
                  child:
                      const Text('→', style: TextStyle(color: starWarsYellow)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
