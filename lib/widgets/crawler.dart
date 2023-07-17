import 'package:flutter/material.dart';
import 'package:star_wars/main.dart';

class Crawler extends StatefulWidget {
  const Crawler({super.key, required this.text});
  final crawlDuration = const Duration(seconds: 20);
  final String text;
  @override
  createState() => _CrawlerState();
}

class _CrawlerState extends State<Crawler> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    Future.delayed(
        const Duration(milliseconds: 1000),
        () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: widget.crawlDuration,
            curve: Curves.linear));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SuperSize(
      height: 1279,
      child: ListView(
        controller: _scrollController,
        children: [
          SizedBox(height: height),
          Text(
            widget.text.trim(),
            style: const TextStyle(
              color: starWarsYellow,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height),
        ],
      ),
    );
  }
}

class SuperSize extends StatelessWidget {
  const SuperSize({super.key, required this.child, this.height = 1000});
  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      minHeight: height,
      maxHeight: height,
      child: child,
    );
  }
}
