import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class CircularProgressScreen extends StatefulWidget {
  const CircularProgressScreen({Key? key}) : super(key: key);

  @override
  State<CircularProgressScreen> createState() => _CircularProgressScreenState();
}

class _CircularProgressScreenState extends State<CircularProgressScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  double actualPercentage = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressWidget(
          actualPercentage: actualPercentage,
          radius: 200,
          barColor: Colors.deepPurple,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            actualPercentage += 10;
            if (actualPercentage > 100) {
              actualPercentage = 0;
            }
          });
        },
      ),
    );
  }
}
