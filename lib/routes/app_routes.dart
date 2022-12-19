import 'package:flutter/material.dart';

import 'package:animations/screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'home';

  static final Map<String, Widget Function(BuildContext)> routes = {
    'animated_screen': (BuildContext context) => const AnimationScreen(),
    'animated_square': (BuildContext context) => const AnimatedSquareScreen(),
    'progress_screen': (BuildContext context) => const CircularProgressScreen(),
    'slideshow': (BuildContext context) => const SlideshowScreen(),
    'pinterest': (BuildContext context) => const PinterestScreen(),
    'home': (BuildContext context) => const HomeScreen(),
  };
}
