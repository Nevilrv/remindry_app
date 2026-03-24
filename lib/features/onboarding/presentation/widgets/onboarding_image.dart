import 'package:flutter/material.dart';

class OnboardingImage extends StatelessWidget {
  final int index;
  final String image;

  const OnboardingImage({
    super.key,
    required this.index,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Stack(
        key: ValueKey(index),
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(image, scale: 0.7),

          /// White gradient overlay
          Container(
            height: 70,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withAlpha(0),
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}