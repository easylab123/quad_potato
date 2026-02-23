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
      title: 'Four Way Traffic Signal',
      home: const TrafficJunction(),
    );
  }
}

class TrafficJunction extends StatefulWidget {
  const TrafficJunction({super.key});

  @override
  State<TrafficJunction> createState() => _TrafficJunctionState();
}

class _TrafficJunctionState extends State<TrafficJunction> {
  Timer? _timer;

  String northSouth = "green";
  String eastWest = "red";

  @override
  void initState() {
    super.initState();
    startTrafficCycle();
  }

  void startTrafficCycle() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        if (northSouth == "green") {
          northSouth = "yellow";
        } else if (northSouth == "yellow") {
          northSouth = "red";
          eastWest = "green";
        } else if (eastWest == "green") {
          eastWest = "yellow";
        } else {
          eastWest = "red";
          northSouth = "green";
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget buildSignal(String state) {
    return Column(
      children: [
        buildLight(Colors.red, state == "red"),
        buildLight(Colors.yellow, state == "yellow"),
        buildLight(Colors.green, state == "green"),
      ],
    );
  }

  Widget buildLight(Color color, bool active) {
    return Container(
      margin: const EdgeInsets.all(6),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? color : color.withOpacity(0.3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Four Way Traffic Signal"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // North Signal
            buildSignal(northSouth),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildSignal(eastWest), // West
                const SizedBox(width: 80),
                buildSignal(eastWest), // East
              ],
            ),

            // South Signal
            buildSignal(northSouth),
          ],
        ),
      ),
    );
  }
}
