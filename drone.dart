import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const DroneControlApp());
}

class DroneControlApp extends StatelessWidget {
  const DroneControlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DroneDashboard(),
    );
  }
}

class DroneDashboard extends StatefulWidget {
  const DroneDashboard({super.key});

  @override
  State<DroneDashboard> createState() => _DroneDashboardState();
}

class _DroneDashboardState extends State<DroneDashboard> {
  bool isFlying = false;
  bool surveillanceMode = false;
  double altitude = 0;
  double speed = 0;
  double battery = 100;

  Timer? telemetryTimer;
  final Random random = Random();

  void startTelemetry() {
    telemetryTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (isFlying) {
          altitude += random.nextDouble() * 2;
          speed = 20 + random.nextDouble() * 10;
          battery -= random.nextDouble() * 1.5;
          if (battery < 0) battery = 0;
        }
      });
    });
  }

  void takeOff() {
    setState(() {
      isFlying = true;
      altitude = 10;
    });
    startTelemetry();
  }

  void land() {
    setState(() {
      isFlying = false;
      altitude = 0;
      speed = 0;
      surveillanceMode = false;
    });
  }

  void toggleSurveillance() {
    setState(() {
      surveillanceMode = !surveillanceMode;
    });
  }

  @override
  void dispose() {
    telemetryTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Border Surveillance Drone"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.flight, size: 100, color: Colors.greenAccent),
            const SizedBox(height: 20),

            Text(
              isFlying ? "STATUS: IN AIR" : "STATUS: LANDED",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent),
            ),

            const SizedBox(height: 30),

            buildTelemetry("Altitude", "${altitude.toStringAsFixed(1)} m"),
            buildTelemetry("Speed", "${speed.toStringAsFixed(1)} km/h"),
            buildTelemetry("Battery", "${battery.toStringAsFixed(1)} %"),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: isFlying ? null : takeOff,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("Take Off"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: isFlying ? land : null,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Land"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: isFlying ? toggleSurveillance : null,
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      surveillanceMode ? Colors.orange : Colors.blue),
              child: Text(
                surveillanceMode
                    ? "Stop Surveillance"
                    : "Start Surveillance",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTelemetry(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16, color: Colors.white70)),
          Text(value,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent)),
        ],
      ),
    );
  }
}