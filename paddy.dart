import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const PaddyRobotApp());
}

class PaddyRobotApp extends StatelessWidget {
  const PaddyRobotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paddy Field Robot',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      home: const RobotDashboard(),
    );
  }
}

class RobotDashboard extends StatefulWidget {
  const RobotDashboard({super.key});

  @override
  State<RobotDashboard> createState() => _RobotDashboardState();
}

class _RobotDashboardState extends State<RobotDashboard> {
  bool isWorking = false;
  String mode = "Idle";
  double battery = 100;
  double soilMoisture = 50;

  Timer? robotTimer;
  final Random random = Random();

  void startRobot(String selectedMode) {
    setState(() {
      isWorking = true;
      mode = selectedMode;
    });

    robotTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        battery -= random.nextDouble() * 2;
        soilMoisture += random.nextDouble() * 3 - 1.5;

        if (battery < 0) battery = 0;
        if (soilMoisture < 0) soilMoisture = 0;
        if (soilMoisture > 100) soilMoisture = 100;
      });
    });
  }

  void stopRobot() {
    robotTimer?.cancel();
    setState(() {
      isWorking = false;
      mode = "Idle";
    });
  }

  Color batteryColor() {
    if (battery > 60) return Colors.green;
    if (battery > 30) return Colors.orange;
    return Colors.red;
  }

  @override
  void dispose() {
    robotTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paddy Field Robot"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.agriculture, size: 90, color: Colors.green),
            const SizedBox(height: 20),

            Text(
              "Status: $mode",
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            buildTelemetry("Battery", "${battery.toStringAsFixed(1)} %",
                valueColor: batteryColor()),
            buildTelemetry("Soil Moisture",
                "${soilMoisture.toStringAsFixed(1)} %"),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: isWorking ? null : () => startRobot("Seeding"),
              child: const Text("Start Seeding"),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: isWorking ? null : () => startRobot("Spraying"),
              child: const Text("Start Spraying"),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: isWorking ? stopRobot : null,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Stop Robot"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTelemetry(String title, String value,
      {Color valueColor = Colors.green}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          Text(
            value,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: valueColor),
          ),
        ],
      ),
    );
  }
}