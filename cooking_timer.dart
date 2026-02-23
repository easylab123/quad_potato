import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const SmartCookingTimerApp());
}

class SmartCookingTimerApp extends StatelessWidget {
  const SmartCookingTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Cooking Timer',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const CookingTimerPage(),
    );
  }
}

class CookingTimerPage extends StatefulWidget {
  const CookingTimerPage({super.key});

  @override
  State<CookingTimerPage> createState() => _CookingTimerPageState();
}

class _CookingTimerPageState extends State<CookingTimerPage> {
  Timer? _timer;
  int totalSeconds = 300; // default 5 minutes
  int remainingSeconds = 300;
  bool isRunning = false;

  String selectedRecipe = "Rice";

  final List<String> recipes = [
    "Rice",
    "Pasta",
    "Egg",
    "Vegetables",
    "Soup",
  ];

  void startTimer() {
    if (isRunning) return;

    setState(() {
      isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          isRunning = false;
        });
        showCompletionAlert();
      }
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      remainingSeconds = totalSeconds;
      isRunning = false;
    });
  }

  void showCompletionAlert() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Cooking Complete 🍲"),
        content: Text("$selectedRecipe is ready!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    double progress = remainingSeconds / totalSeconds;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Circular Cooking Timer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Recipe Selection
            DropdownButton<String>(
              value: selectedRecipe,
              isExpanded: true,
              items: recipes.map((recipe) {
                return DropdownMenuItem(
                  value: recipe,
                  child: Text(recipe),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRecipe = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            // Circular Timer
            SizedBox(
              height: 220,
              width: 220,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 12,
                    backgroundColor: Colors.grey.shade300,
                  ),
                  Text(
                    formatTime(remainingSeconds),
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Duration Selector
            Text("Cooking Duration: ${totalSeconds ~/ 60} minutes"),
            Slider(
              value: totalSeconds.toDouble(),
              min: 60,
              max: 1800,
              divisions: 29,
              label: "${totalSeconds ~/ 60} min",
              onChanged: isRunning
                  ? null
                  : (value) {
                      setState(() {
                        totalSeconds = value.toInt();
                        remainingSeconds = totalSeconds;
                      });
                    },
            ),

            const SizedBox(height: 20),

            // Control Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: startTimer,
                  child: const Text("Start"),
                ),
                ElevatedButton(
                  onPressed: pauseTimer,
                  child: const Text("Pause"),
                ),
                ElevatedButton(
                  onPressed: resetTimer,
                  child: const Text("Reset"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
