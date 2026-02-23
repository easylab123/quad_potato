import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const TrafficSignalApp());
}

class TrafficSignalApp extends StatelessWidget {
  const TrafficSignalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TrafficJunctionPage(),
    );
  }
}

class TrafficJunctionPage extends StatefulWidget {
  @override
  _TrafficJunctionPageState createState() => _TrafficJunctionPageState();
}

class _TrafficJunctionPageState extends State<TrafficJunctionPage> {
  TrafficLightState currentState = TrafficLightState.red;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startSignalCycle();
  }

  void startSignalCycle() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        if (currentState == TrafficLightState.red) {
          currentState = TrafficLightState.green;
        } else if (currentState == TrafficLightState.green) {
          currentState = TrafficLightState.yellow;
        } else {
          currentState = TrafficLightState.red;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Traffic Junction Signals")),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TrafficLight(currentState),
            TrafficLight(currentState),
            TrafficLight(currentState),
            TrafficLight(currentState),
          ],
        ),
      ),
    );
  }
}

enum TrafficLightState { red, yellow, green }

class TrafficLight extends StatelessWidget {
  final TrafficLightState state;

  const TrafficLight(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildLight(Colors.red, state == TrafficLightState.red),
        buildLight(Colors.yellow, state == TrafficLightState.yellow),
        buildLight(Colors.green, state == TrafficLightState.green),
      ],
    );
  }

  Widget buildLight(Color color, bool isOn) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isOn ? color : color.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
    );
  }
}
