import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const TrafficLightApp());
}

class TrafficLightApp extends StatelessWidget {
  const TrafficLightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TrafficLightPage(),
    );
  }
}

class TrafficLightPage extends StatefulWidget {
  @override
  State<TrafficLightPage> createState() => _TrafficLightPageState();
}

class _TrafficLightPageState extends State<TrafficLightPage> {
  int currentLight = 0; // 0-Red, 1-Yellow, 2-Green
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTrafficCycle();
  }

  void startTrafficCycle() {
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        currentLight = (currentLight + 1) % 3;
      });
    });
  }

  Color getColor(int index) {
    if (currentLight == index) {
      switch (index) {
        case 0:
          return Colors.red;
        case 1:
          return Colors.yellow;
        case 2:
          return Colors.green;
      }
    }
    return Colors.grey.shade400;
  }

  Widget buildLight(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.all(10),
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: getColor(index),
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animated Traffic Lights")),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildLight(0), // Red
              buildLight(1), // Yellow
              buildLight(2), // Green
            ],
          ),
        ),
      ),
    );
  }
}
