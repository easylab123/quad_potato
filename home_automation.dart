import 'package:flutter/material.dart';

void main() {
  runApp(const HomeAutomationApp());
}

class HomeAutomationApp extends StatelessWidget {
  const HomeAutomationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Automation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeAutomationPage(),
    );
  }
}

class HomeAutomationPage extends StatefulWidget {
  const HomeAutomationPage({super.key});

  @override
  State<HomeAutomationPage> createState() => _HomeAutomationPageState();
}

class _HomeAutomationPageState extends State<HomeAutomationPage> {
  bool lightOn = false;
  bool fanOn = false;
  bool doorOpen = false;
  bool alarmOn = false;

  Widget deviceTile({
    required String title,
    required IconData icon,
    required bool status,
    required GestureDetector gesture,
  }) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: status ? Colors.green.shade300 : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: gesture,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Home Automation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [

            // Light Control (Tap)
            deviceTile(
              title: "Light",
              icon: Icons.lightbulb,
              status: lightOn,
              gesture: GestureDetector(
                onTap: () {
                  setState(() {
                    lightOn = !lightOn;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lightbulb, size: 50),
                    const SizedBox(height: 10),
                    Text(lightOn ? "Light ON" : "Light OFF"),
                    const Text("(Tap)")
                  ],
                ),
              ),
            ),

            // Fan Control (Double Tap)
            deviceTile(
              title: "Fan",
              icon: Icons.toys,
              status: fanOn,
              gesture: GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    fanOn = !fanOn;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.toys, size: 50),
                    const SizedBox(height: 10),
                    Text(fanOn ? "Fan ON" : "Fan OFF"),
                    const Text("(Double Tap)")
                  ],
                ),
              ),
            ),

            // Door Control (Long Press)
            deviceTile(
              title: "Door",
              icon: Icons.door_front_door,
              status: doorOpen,
              gesture: GestureDetector(
                onLongPress: () {
                  setState(() {
                    doorOpen = !doorOpen;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.door_front_door, size: 50),
                    const SizedBox(height: 10),
                    Text(doorOpen ? "Door OPEN" : "Door CLOSED"),
                    const Text("(Long Press)")
                  ],
                ),
              ),
            ),

            // Alarm Control (Swipe)
            deviceTile(
              title: "Alarm",
              icon: Icons.alarm,
              status: alarmOn,
              gesture: GestureDetector(
                onHorizontalDragEnd: (_) {
                  setState(() {
                    alarmOn = !alarmOn;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.alarm, size: 50),
                    const SizedBox(height: 10),
                    Text(alarmOn ? "Alarm ON" : "Alarm OFF"),
                    const Text("(Swipe)")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
