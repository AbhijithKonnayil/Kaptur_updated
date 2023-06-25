import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'mock_data.dart';

class CarouselBuilder extends StatefulWidget {
  const CarouselBuilder({super.key});

  @override
  State<CarouselBuilder> createState() => _CarouselBuilderState();
}

class _CarouselBuilderState extends State<CarouselBuilder> {
  final double _anchor = 0.0;
  final bool _center = true;
  final double _velocityFactor = 0.1;
  final double _itemExtent = 250;
  late InfiniteScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = InfiniteScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InfiniteCarousel.builder(
      itemCount: kDemoImages.length,
      itemExtent: _itemExtent,
      center: _center,
      anchor: _anchor,
      velocityFactor: _velocityFactor,
      controller: _controller,
      itemBuilder: (context, itemIndex, realIndex) {
        final currentOffset = _itemExtent * realIndex;

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final diff = (_controller.offset - currentOffset);

            const maxPadding = 10.0;

            final carouselRatio = _itemExtent / maxPadding;

            return Padding(
              padding: EdgeInsets.only(
                top: (diff / carouselRatio).abs(),
                bottom: (diff / carouselRatio).abs(),
              ),
              child: child,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: kElevationToShadow[2],
                image: DecorationImage(
                  image: NetworkImage(kDemoImages[itemIndex]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
