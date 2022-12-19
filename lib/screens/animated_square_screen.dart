import 'package:flutter/material.dart';

class AnimatedSquareScreen extends StatelessWidget {
  const AnimatedSquareScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: _AnimatedSquare(),
      ),
    );
  }
}

class _AnimatedSquare extends StatefulWidget {
  const _AnimatedSquare({
    Key? key,
  }) : super(key: key);

  @override
  State<_AnimatedSquare> createState() => _AnimatedSquareState();
}

class _AnimatedSquareState extends State<_AnimatedSquare>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> position1;
  late Animation<double> position2;
  late Animation<double> position3;
  late Animation<double> position4;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4500));

    position1 = Tween(begin: 0.0, end: 100.0).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0, 0.25)));

    position2 = Tween(begin: 0.0, end: -100.0).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0.25, 0.50)));

    position3 = Tween(begin: 0.0, end: 100.0).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0.50, 0.75)));

    position4 = Tween(begin: 0.0, end: -100.0).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0.75, 1)));

    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) {
        controller.reset();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();

    return AnimatedBuilder(
      animation: controller,
      child: const _Rectangle(),
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(position1.value - position3.value,
              position2.value - position4.value),
          child: child,
        );
      },
    );
  }
}

class _Rectangle extends StatelessWidget {
  const _Rectangle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      color: Colors.lightBlue,
    );
  }
}
