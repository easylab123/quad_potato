import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const RetinalCaptioningApp());
}

class RetinalCaptioningApp extends StatelessWidget {
  const RetinalCaptioningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Retinal Fundus Captioning',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RetinalCaptioningPage(),
    );
  }
}

class RetinalCaptioningPage extends StatefulWidget {
  const RetinalCaptioningPage({super.key});

  @override
  State<RetinalCaptioningPage> createState() =>
      _RetinalCaptioningPageState();
}

class _RetinalCaptioningPageState extends State<RetinalCaptioningPage> {
  XFile? _image;

  String selectedModel = "CNN-LSTM with Attention";
  double temperature = 0.7;
  int maxLength = 30;

  String generatedCaption = "Caption will appear here...";

  final List<String> models = [
    "CNN-LSTM with Attention",
    "ViT + Transformer Decoder",
    "ResNet + LSTM",
    "EfficientNet + Transformer",
  ];

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final picked =
        await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _image = picked;
      });
    }
  }

  void generateCaption() {
    setState(() {
      generatedCaption =
          "Moderate DR detected with multiple microaneurysms and hemorrhages. Vascular abnormalities are present.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Retinal Fundus Captioning"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image Preview
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: _image == null
                    ? const Center(
                        child: Text("No Image Selected"))
                    : Image.network(
                        _image!.path,
                        fit: BoxFit.cover,
                      ),
              ),
            ),

            const SizedBox(height: 10),

            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.image),
                label: const Text("Select Fundus Image"),
                onPressed: pickImage,
              ),
            ),

            const Divider(height: 30),

            /// Model Selection
            const Text(
              "Select Captioning Model",
              style:
                  TextStyle(fontWeight: FontWeight.bold),
            ),

            DropdownButton<String>(
              value: selectedModel,
              isExpanded: true,
              items: models.map((model) {
                return DropdownMenuItem(
                  value: model,
                  child: Text(model),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedModel = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            /// Temperature
            Text(
                "Temperature: ${temperature.toStringAsFixed(2)}"),
            Slider(
              value: temperature,
              min: 0.1,
              max: 1.0,
              divisions: 9,
              onChanged: (value) {
                setState(() {
                  temperature = value;
                });
              },
            ),

            /// Max Caption Length
            Text("Max Caption Length: $maxLength"),
            Slider(
              value: maxLength.toDouble(),
              min: 10,
              max: 50,
              divisions: 8,
              onChanged: (value) {
                setState(() {
                  maxLength = value.toInt();
                });
              },
            ),

            const SizedBox(height: 20),

            /// Generate Caption
            Center(
              child: ElevatedButton(
                onPressed: generateCaption,
                child:
                    const Text("Generate Caption"),
              ),
            ),

            const Divider(height: 30),

            /// Caption Output
            const Text(
              "Generated Medical Caption",
              style:
                  TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius:
                    BorderRadius.circular(8),
              ),
              child: Text(
                generatedCaption,
                style:
                    const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}