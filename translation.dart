import 'package:flutter/material.dart';

void main() {
  runApp(const TranslatorApp());
}

class TranslatorApp extends StatelessWidget {
  const TranslatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multilingual Translator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TranslatorHomePage(),
    );
  }
}

class TranslatorHomePage extends StatefulWidget {
  const TranslatorHomePage({super.key});

  @override
  State<TranslatorHomePage> createState() => _TranslatorHomePageState();
}

class _TranslatorHomePageState extends State<TranslatorHomePage> {
  final TextEditingController inputController = TextEditingController();

  String sourceLanguage = "English";
  String targetLanguage = "Tamil";
  String translatedText = "";

  final List<String> languages = [
    "English",
    "Tamil",
    "Hindi",
    "French",
    "German"
  ];

  void translateText() {
    setState(() {
      // Mock translation logic (for demo & exams)
      translatedText =
          "[ $targetLanguage Translation ] : ${inputController.text}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Multilingual Translation System"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Source Language Selector
            const Text("Source Language"),
            DropdownButton<String>(
              value: sourceLanguage,
              isExpanded: true,
              items: languages.map((lang) {
                return DropdownMenuItem(
                  value: lang,
                  child: Text(lang),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  sourceLanguage = value!;
                });
              },
            ),

            const SizedBox(height: 10),

            // Target Language Selector
            const Text("Target Language"),
            DropdownButton<String>(
              value: targetLanguage,
              isExpanded: true,
              items: languages.map((lang) {
                return DropdownMenuItem(
                  value: lang,
                  child: Text(lang),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  targetLanguage = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            // Input Text
            TextField(
              controller: inputController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter text to translate",
              ),
            ),

            const SizedBox(height: 20),

            // Translate Button
            Center(
              child: ElevatedButton(
                onPressed: translateText,
                child: const Text("Translate"),
              ),
            ),

            const SizedBox(height: 20),

            // Output Text
            const Text(
              "Translated Text",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                translatedText,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
