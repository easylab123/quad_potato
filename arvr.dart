import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ARVRCameraApp());
}

class ARVRCameraApp extends StatelessWidget {
  const ARVRCameraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ARVRCameraScreen(),
    );
  }
}

class ARVRCameraScreen extends StatefulWidget {
  const ARVRCameraScreen({super.key});

  @override
  State<ARVRCameraScreen> createState() => _ARVRCameraScreenState();
}

class _ARVRCameraScreenState extends State<ARVRCameraScreen> {
  CameraController? _controller;
  bool isCameraInitialized = false;
  bool isARMode = true;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();

    _controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
    );

    await _controller!.initialize();

    if (!mounted) return;

    setState(() {
      isCameraInitialized = true;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void toggleMode() {
    setState(() {
      isARMode = !isARMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isCameraInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background Camera
          isARMode
              ? CameraPreview(_controller!)
              : Row(
                  children: [
                    Expanded(child: CameraPreview(_controller!)),
                    Expanded(child: CameraPreview(_controller!)),
                  ],
                ),

          // AR Overlay
          if (isARMode)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.greenAccent, width: 4),
                ),
                child: const Center(
                  child: Text(
                    "AR MODE",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
              ),
            ),

          // Toggle Button
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: toggleMode,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 15),
                ),
                child: Text(
                  isARMode ? "Switch to VR Mode" : "Switch to AR Mode",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}