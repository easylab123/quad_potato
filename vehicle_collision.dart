import 'package:flutter/material.dart';

void main() {
  runApp(const SV2GASApp());
}

class SV2GASApp extends StatelessWidget {
  const SV2GASApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SV2GAS',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const CollisionDashboard(),
    );
  }
}

class CollisionDashboard extends StatefulWidget {
  const CollisionDashboard({super.key});

  @override
  State<CollisionDashboard> createState() => _CollisionDashboardState();
}

class _CollisionDashboardState extends State<CollisionDashboard> {
  double speed = 40;
  double distance = 60;

  String alertText = "SAFE";
  Color alertColor = Colors.green;
  IconData alertIcon = Icons.check_circle;

  void evaluateCollisionRisk() {
    setState(() {
      if (distance > 50) {
        alertText = "SAFE";
        alertColor = Colors.green;
        alertIcon = Icons.check_circle;
      } else if (distance > 20) {
        alertText = "WARNING";
        alertColor = Colors.orange;
        alertIcon = Icons.warning;
      } else {
        alertText = "DANGER";
        alertColor = Colors.red;
        alertIcon = Icons.error;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart V2V Collision Avoidance (SV2GAS)"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// Vehicle Speed
            Card(
              child: ListTile(
                title: const Text("Vehicle Speed (km/h)"),
                subtitle: Slider(
                  min: 0,
                  max: 120,
                  value: speed,
                  divisions: 12,
                  label: speed.round().toString(),
                  onChanged: (value) {
                    setState(() => speed = value);
                    evaluateCollisionRisk();
                  },
                ),
                trailing: Text("${speed.toInt()} km/h"),
              ),
            ),

            /// Distance
            Card(
              child: ListTile(
                title: const Text("Distance to Front Vehicle (m)"),
                subtitle: Slider(
                  min: 0,
                  max: 100,
                  value: distance,
                  divisions: 20,
                  label: distance.round().toString(),
                  onChanged: (value) {
                    setState(() => distance = value);
                    evaluateCollisionRisk();
                  },
                ),
                trailing: Text("${distance.toInt()} m"),
              ),
            ),

            const SizedBox(height: 30),

            /// Alert Display
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: alertColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: alertColor, width: 2),
              ),
              child: Column(
                children: [
                  Icon(alertIcon, size: 80, color: alertColor),
                  const SizedBox(height: 10),
                  Text(
                    alertText,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: alertColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    alertText == "SAFE"
                        ? "Maintain current speed"
                        : alertText == "WARNING"
                            ? "Reduce speed immediately"
                            : "Apply brakes! Collision imminent!",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// Footer
            const Text(
              "SV2GAS • Smart V2V Safety System",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
