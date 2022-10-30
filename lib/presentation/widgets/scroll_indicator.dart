import 'package:flutter/material.dart';

class ScrollIndicator extends StatefulWidget {
  final ScrollController scrollController;
  final PageController pageController;
  final double width;
  final double height;
  final double indicatorWidth;
  final Decoration decoration;
  final Decoration indicatorDecoration;
  final AlignmentGeometry alignment;

  const ScrollIndicator({
    required this.scrollController,
    required this.pageController,
    this.width = 100,
    this.height = 10,
    this.indicatorWidth = 20,
    this.decoration = const BoxDecoration(color: Colors.black26),
    this.indicatorDecoration = const BoxDecoration(color: Colors.black),
    this.alignment = Alignment.center,
  });

  @override
  _ScrollIndicatorState createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<ScrollIndicator> {
  double currentPixels = 0.0;
  double mainContainer = 0.0;
  double move = 0.0;

  @override
  void initState() {
    widget.scrollController.addListener(() {
      _scrollListener();
    });
    widget.pageController.addListener(() {
      _pageListener();
    });
    super.initState();
  }

  void _scrollListener() {
    setState(() {
      currentPixels = widget.scrollController.position.pixels;
      mainContainer =
          widget.scrollController.position.maxScrollExtent / widget.width;
      move = currentPixels / mainContainer;
    });
  }

  void _pageListener() {
    setState(() {
      currentPixels = widget.pageController.position.pixels;
      mainContainer =
          widget.pageController.position.maxScrollExtent / widget.width;
      move = currentPixels / mainContainer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: Container(
        height: widget.height,
        width: widget.width + widget.indicatorWidth,
        decoration: widget.decoration,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: move,
              child: Container(
                height: widget.height,
                width: widget.indicatorWidth,
                decoration: widget.indicatorDecoration,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
