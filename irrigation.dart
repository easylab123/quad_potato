import 'package:flutter/material.dart';

void main() {
  runApp(SmartIrrigationApp());
}

class SmartIrrigationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Irrigation System',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int moistureLevel = 45;   // Sample moisture percentage
  bool motorOn = false;

  void turnOnMotor() {
    setState(() {
      motorOn = true;
    });
  }

  void turnOffMotor() {
    setState(() {
      motorOn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Irrigation System"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Soil Moisture Level: $moistureLevel%",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),

            SizedBox(height: 20),

            Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  motorOn ? "Motor Status: ON" : "Motor Status: OFF",
                  style: TextStyle(
                    fontSize: 20,
                    color: motorOn ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: turnOnMotor,
                  child: Text("Turn ON"),
                ),
                ElevatedButton(
                  onPressed: turnOffMotor,
                  child: Text("Turn OFF"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}