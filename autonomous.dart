import 'package:flutter/material.dart';

void main() {
  runApp(const AutonomousCarApp());
}

class AutonomousCarApp extends StatelessWidget {
  const AutonomousCarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Autonomous Car Driving System',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String navigationMode = "Autonomous AI";
  double speed = 45;
  double obstacleDistance = 12.5;

  Map<String, bool> sensors = {
    "LiDAR": true,
    "Camera": true,
    "Radar": true,
    "Ultrasonic": true,
    "GPS": true,
    "IMU": true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Autonomous Car Driving System"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _navigationSelector(),
            const SizedBox(height: 16),
            _sensorGrid(),
            const SizedBox(height: 16),
            _environmentPanel(),
            const SizedBox(height: 16),
            _controlPanel(),
            const SizedBox(height: 16),
            _statusConsole(),
          ],
        ),
      ),
    );
  }

  // 🚘 Navigation Mode Selector
  Widget _navigationSelector() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Text("Navigation Mode:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 20),
            DropdownButton<String>(
              value: navigationMode,
              items: [
                "GPS Navigation",
                "Lane Following",
                "Obstacle Avoidance",
                "Autonomous AI",
                "Manual Override",
              ].map((mode) {
                return DropdownMenuItem(
                  value: mode,
                  child: Text(mode),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  navigationMode = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // 📡 Sensor Grid
  Widget _sensorGrid() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.3,
        children: sensors.keys.map((sensor) {
          return Card(
            elevation: 2,
            child: SwitchListTile(
              title: Text(sensor),
              value: sensors[sensor]!,
              onChanged: (value) {
                setState(() {
                  sensors[sensor] = value;
                });
              },
              secondary: Icon(
                sensors[sensor]! ? Icons.check_circle : Icons.error,
                color: sensors[sensor]! ? Colors.green : Colors.red,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // 🌍 Environment Observation Panel
  Widget _environmentPanel() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _envItem("Speed", "$speed km/h", Icons.speed),
            _envItem("Obstacle", "$obstacleDistance m", Icons.warning),
            _envItem("Lane", "Detected", Icons.alt_route),
            _envItem("Traffic Sign", "Stop", Icons.traffic),
          ],
        ),
      ),
    );
  }

  Widget _envItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.blueGrey),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }

  // 🎮 Vehicle Control Panel
  Widget _controlPanel() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Vehicle Control",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Slider(
              min: 0,
              max: 120,
              value: speed,
              label: "${speed.toInt()} km/h",
              onChanged: (value) {
                setState(() {
                  speed = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // 🧾 Status Console
  Widget _statusConsole() {
    return Card(
      elevation: 2,
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          "Mode: $navigationMode | "
          "Speed: ${speed.toInt()} km/h | "
          "Obstacle: ${obstacleDistance} m | "
          "Sensors Active: ${sensors.values.where((v) => v).length}/6",
          style: const TextStyle(color: Colors.greenAccent),
        ),
      ),
    );
  }
}
