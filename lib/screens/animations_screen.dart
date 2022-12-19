import 'package:flutter/material.dart';
import 'dart:math';

class AnimationScreen extends StatelessWidget {
  const AnimationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AnimatedRectangle(),
      ),
    );
  }
}

class AnimatedRectangle extends StatefulWidget {
  const AnimatedRectangle({
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedRectangle> createState() => _AnimatedRectangleState();
}

class _AnimatedRectangleState extends State<AnimatedRectangle>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotation;
  late Animation<double> opacity;
  late Animation<double> moveRigth;
  late Animation<double> sizeUp;
  late Animation<double> fadeOut;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4000));

    // rotation = Tween(begin: 0.0, end: pi * 2).animate(controller);
    rotation = Tween(begin: 0.0, end: pi * 2)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    opacity = Tween(begin: 0.1, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0, 0.5)));

    fadeOut = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0.75, 1.0)));

    moveRigth = Tween(begin: 0.0, end: 190.0).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0, 0.5)));

    sizeUp = Tween(begin: 0.0, end: 1.8)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

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
    //Like the play button to start the animation
    controller.forward();

    return AnimatedBuilder(
      animation: controller,
      child: const _Rectangle(),
      builder: (BuildContext context, Widget? childRectangle) {
        return Transform.translate(
          offset: Offset(moveRigth.value, 0.0),
          child: Transform.rotate(
            angle: rotation.value,
            child: Opacity(
                opacity: opacity.value - fadeOut.value,
                child: Transform.scale(
                  scale: sizeUp.value,
                  child: childRectangle,
                )),
          ),
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
