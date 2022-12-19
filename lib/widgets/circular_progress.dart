import 'dart:math';

import 'package:flutter/material.dart';

class CircularProgressWidget extends StatefulWidget {
  const CircularProgressWidget({
    Key? key,
    required this.actualPercentage,
    required this.radius,
    this.barColor = Colors.lightBlue,
    this.secondaryColor = Colors.black38,
    this.barThickness = 8,
    this.secondaryBarThickness = 5,
  }) : super(key: key);

  final double actualPercentage;
  final double radius;
  final double barThickness;
  final double secondaryBarThickness;
  final Color barColor;
  final Color secondaryColor;

  @override
  State<CircularProgressWidget> createState() => _CircularProgressWidgetState();
}

class _CircularProgressWidgetState extends State<CircularProgressWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  double newPercentage = 0.0;

  @override
  void initState() {
    newPercentage = widget.actualPercentage;
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);
    final diferenciaAnimar = widget.actualPercentage - newPercentage;
    newPercentage = widget.actualPercentage;
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
          padding: const EdgeInsets.all(10),
          width: widget.radius,
          height: widget.radius,
          child: CustomPaint(
            painter: CircularProgressPainter(
                percentage: (widget.actualPercentage - diferenciaAnimar) +
                    (diferenciaAnimar * controller.value),
                barColor: widget.barColor,
                secondaryColor: widget.secondaryColor,
                barThickness: widget.barThickness,
                secondaryBarThickness: widget.secondaryBarThickness),
          ),
        );
      },
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  CircularProgressPainter({
    required this.percentage,
    required this.barColor,
    required this.secondaryColor,
    required this.barThickness,
    required this.secondaryBarThickness,
  });

  final double percentage;
  final double barThickness;
  final double secondaryBarThickness;
  final Color barColor;
  final Color secondaryColor;

  //Completed Circle
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 5
      ..color = Colors.black38
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width * 0.5, size.height * 0.5);
    final radius = min(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(center, radius, paint);

    //Progress
    final paintProgress = Paint()
      ..strokeWidth = 10
      ..color = barColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressAngle = 2 * pi * (percentage / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        progressAngle, false, paintProgress);
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(CircularProgressPainter oldDelegate) => false;
}
