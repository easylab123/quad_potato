import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:vibration/vibration.dart';

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
      theme: ThemeData(primarySwatch: Colors.deepOrange),
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
  int totalSeconds = 300;
  int remainingSeconds = 300;
  bool isRunning = false;

  String selectedRecipe = "Rice";
  final List<String> recipes = ["Rice", "Pasta", "Egg", "Vegetables", "Soup"];

  final FlutterTts tts = FlutterTts();
  late stt.SpeechToText speech;
  bool isListening = false;

  @override
  void initState() {
    super.initState();
    speech = stt.SpeechToText();
  }

  // ---------------- TIMER LOGIC ----------------

  void startTimer() {
    if (isRunning) return;

    setState(() => isRunning = true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() => remainingSeconds--);
      } else {
        timer.cancel();
        isRunning = false;
        cookingCompleted();
      }
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    setState(() => isRunning = false);
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      remainingSeconds = totalSeconds;
      isRunning = false;
    });
  }

  // ---------------- ALERTS ----------------

  void cookingCompleted() async {
    await tts.speak("Cooking completed. Your $selectedRecipe is ready to eat.");
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 1000);
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Cooking Done 🍲"),
        content: Text("$selectedRecipe is ready to serve!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  // ---------------- VOICE CONTROL ----------------

  void listenVoiceCommand() async {
    if (!isListening) {
      bool available = await speech.initialize();
      if (available) {
        setState(() => isListening = true);
        speech.listen(onResult: (result) {
          handleCommand(result.recognizedWords.toLowerCase());
        });
      }
    } else {
      speech.stop();
      setState(() => isListening = false);
    }
  }

  void handleCommand(String command) {
    if (command.contains("start")) startTimer();
    if (command.contains("pause")) pauseTimer();
    if (command.contains("reset")) resetTimer();
    if (command.contains("one")) setDuration(1);
    if (command.contains("two")) setDuration(2);
    if (command.contains("three")) setDuration(3);
    if (command.contains("four")) setDuration(4);
    if (command.contains("five")) setDuration(5);
    if (command.contains("ten")) setDuration(10);
    if (command.contains("fifteen")) setDuration(15);
    if (command.contains("twenty")) setDuration(20);
  }

  void setDuration(int minutes) {
    setState(() {
      totalSeconds = minutes * 60;
      remainingSeconds = totalSeconds;
    });
    tts.speak("Timer set for $minutes minutes");
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    double percent = remainingSeconds / totalSeconds;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Cooking Timer"),
        actions: [
          IconButton(
            icon: Icon(isListening ? Icons.mic : Icons.mic_none),
            onPressed: listenVoiceCommand,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // Circular Timer
          CircularPercentIndicator(
            radius: 140,
            lineWidth: 14,
            percent: percent,
            animation: true,
            center: Text(
              "${remainingSeconds ~/ 60}:${(remainingSeconds % 60).toString().padLeft(2, '0')}",
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            progressColor: Colors.deepOrange,
            backgroundColor: Colors.grey.shade300,
          ),

          const SizedBox(height: 20),

          // Recipe Selection
          DropdownButton<String>(
            value: selectedRecipe,
            items: recipes.map((r) {
              return DropdownMenuItem(value: r, child: Text(r));
            }).toList(),
            onChanged: (value) {
              setState(() => selectedRecipe = value!);
            },
          ),

          const SizedBox(height: 20),

          // Duration Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () => setDuration(1), child: const Text("1 min")),
              const SizedBox(width: 10),
              ElevatedButton(onPressed: () => setDuration(2), child: const Text("2 min")),
              const SizedBox(width: 10),
              ElevatedButton(onPressed: () => setDuration(3), child: const Text("3 min")),
              const SizedBox(width: 10),
              ElevatedButton(onPressed: () => setDuration(4), child: const Text("4 min")),
              const SizedBox(width: 10),
              ElevatedButton(onPressed: () => setDuration(5), child: const Text("5 min")),
              const SizedBox(width: 10),
              ElevatedButton(onPressed: () => setDuration(10), child: const Text("10 min")),
              const SizedBox(width: 10),
              ElevatedButton(onPressed: () => setDuration(15), child: const Text("15 min")),
              const SizedBox(width: 10),
              ElevatedButton(onPressed: () => setDuration(15), child: const Text("15 min")),
              const SizedBox(width: 10), 
            ],
          ),

          const SizedBox(height: 20),

          // Control Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: startTimer, child: const Text("Start")),
              const SizedBox(width: 10),
              ElevatedButton(onPressed: pauseTimer, child: const Text("Pause")),
              const SizedBox(width: 10),
              ElevatedButton(onPressed: resetTimer, child: const Text("Reset")),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    speech.stop();
    super.dispose();
  }
}
