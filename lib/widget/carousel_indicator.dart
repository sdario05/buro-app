import 'package:flutter/material.dart';

class CarouselIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;
  final double dotSize;
  final Color activeColor;
  final Color inactiveColor;
  final double spacing;

  const CarouselIndicator({
    Key? key,
    required this.currentIndex,
    required this.itemCount,
    this.dotSize = 8.0,
    this.activeColor = Colors.black,
    this.inactiveColor = const Color(0xFFD3D3D3),
    this.spacing = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => Container(
          width: dotSize,
          height: dotSize,
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index ? activeColor : inactiveColor,
          ),
        ),
      ),
    );
  }
}
