import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:taskify/utils/shared.dart';

class SplashScreen extends StatelessWidget {
  final Widget nextScreen;
  const SplashScreen({
    super.key,
    required this.nextScreen,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: backgroundColour,
      splashIconSize: 250,
      duration: 1100,
      splash: Image.asset(
        "assets/images/logo.png",
        fit: BoxFit.contain,
      ),
      nextScreen: nextScreen,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.bottomToTop,
    );
  }
}
