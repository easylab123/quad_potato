import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const ReactorControlApp());
}

class ReactorControlApp extends StatelessWidget {
  const ReactorControlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nuclear Reactor Control',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.greenAccent,
      ),
      home: const ReactorDashboard(),
    );
  }
}

class ReactorDashboard extends StatefulWidget {
  const ReactorDashboard({super.key});

  @override
  State<ReactorDashboard> createState() => _ReactorDashboardState();
}

class _ReactorDashboardState extends State<ReactorDashboard> {
  bool isActive = false;
  double temperature = 300; // °C
  double powerOutput = 0;   // MW
  double stability = 100;   // %

  Timer? reactorTimer;
  final Random random = Random();

  void startReactor() {
    setState(() {
      isActive = true;
    });

    reactorTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        temperature += random.nextDouble() * 15;
        powerOutput += random.nextDouble() * 50;
        stability -= random.nextDouble() * 2;

        if (stability < 0) stability = 0;
      });
    });
  }

  void shutdownReactor() {
    reactorTimer?.cancel();
    setState(() {
      isActive = false;
      temperature = 300;
      powerOutput = 0;
      stability = 100;
    });
  }

  Color getStabilityColor() {
    if (stability > 70) return Colors.greenAccent;
    if (stability > 40) return Colors.orange;
    return Colors.red;
  }

  @override
  void dispose() {
    reactorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuclear Reactor Control"),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.warning_amber_rounded,
                size: 80, color: Colors.greenAccent),
            const SizedBox(height: 20),

            Text(
              isActive ? "REACTOR STATUS: ACTIVE" : "REACTOR STATUS: OFFLINE",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent),
            ),

            const SizedBox(height: 30),

            buildTelemetry("Core Temperature", "${temperature.toStringAsFixed(1)} °C"),
            buildTelemetry("Power Output", "${powerOutput.toStringAsFixed(1)} MW"),
            buildTelemetry("Core Stability", "${stability.toStringAsFixed(1)} %",
                valueColor: getStabilityColor()),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: isActive ? null : startReactor,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.black),
              child: const Text("Start Reactor"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: isActive ? shutdownReactor : null,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red),
              child: const Text("Emergency Shutdown"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTelemetry(String title, String value, {Color valueColor = Colors.greenAccent}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16, color: Colors.white70)),
          Text(value,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: valueColor)),
        ],
      ),
    );
  }
}