import 'package:flutter/material.dart';

void main() {
  runApp(RetinalDRApp());
}

class RetinalDRApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Retinal DR Classification',
      home: RetinalClassificationPage(),
    );
  }
}

class RetinalClassificationPage extends StatefulWidget {
  @override
  _RetinalClassificationPageState createState() =>
      _RetinalClassificationPageState();
}

class _RetinalClassificationPageState
    extends State<RetinalClassificationPage> {
  String selectedModel = 'CNN + DenseNet';
  String selectedSeverity = '---';
  double learningRate = 0.001;
  int epochs = 10;

  final List<String> models = [
    'CNN + DenseNet',
    'CNN + ResNet',
    'CNN + Vision Transformer',
    'CNN + MobileNet'
  ];

  final List<String> severityLevels = [
    'Normal',
    'Mild DR',
    'Moderate DR',
    'Severe DR',
    'Proliferative DR'
  ];

  void classifyImage() {
    setState(() {
      // Dummy prediction (UI simulation)
      selectedSeverity =
          severityLevels[DateTime.now().millisecond % 5];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retinal Fundus Classification'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Model Selection
              Text('Select Trained Model',
                  style: TextStyle(fontWeight: FontWeight.bold)),
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

              SizedBox(height: 20),

              /// Image Selection Placeholder
              Text('Select Retinal Fundus Image',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(Icons.image, size: 50),
                ),
              ),

              SizedBox(height: 20),

              /// Hyperparameters
              Text('Hyperparameters',
                  style: TextStyle(fontWeight: FontWeight.bold)),

              SizedBox(height: 10),
              Text('Learning Rate: ${learningRate.toStringAsFixed(4)}'),
              Slider(
                min: 0.0001,
                max: 0.01,
                divisions: 10,
                value: learningRate,
                onChanged: (value) {
                  setState(() {
                    learningRate = value;
                  });
                },
              ),

              SizedBox(height: 10),
              Text('Epochs: $epochs'),
              Slider(
                min: 5,
                max: 50,
                divisions: 9,
                value: epochs.toDouble(),
                onChanged: (value) {
                  setState(() {
                    epochs = value.toInt();
                  });
                },
              ),

              SizedBox(height: 20),

              /// Classify Button
              Center(
                child: ElevatedButton(
                  onPressed: classifyImage,
                  child: Text('Classify Image'),
                ),
              ),

              SizedBox(height: 30),

              /// Result Display
              Center(
                child: Column(
                  children: [
                    Text(
                      'Predicted Severity Level',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      selectedSeverity,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
