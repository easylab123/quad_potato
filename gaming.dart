import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CatchGame(),
  ));
}

class CatchGame extends StatefulWidget {
  @override
  _CatchGameState createState() => _CatchGameState();
}

class _CatchGameState extends State<CatchGame>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double starX = 100;
  double starY = 0;
  double basketX = 100;
  int score = 0;
  double screenWidth = 0;
  double screenHeight = 0;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..addListener(() {
            setState(() {
              starY += 5;

              if (starY > screenHeight) {
                _resetStar();
              }

              if ((starY > screenHeight - 120) &&
                  (starX > basketX - 40 && starX < basketX + 100)) {
                score++;
                _resetStar();
              }
            });
          })
          ..repeat();
  }

  void _resetStar() {
    starY = 0;
    starX = Random().nextDouble() * (screenWidth - 50);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            basketX += details.delta.dx;
            basketX = basketX.clamp(0, screenWidth - 100);
          });
        },
        child: Stack(
          children: [
            Positioned(
              top: starY,
              left: starX,
              child: Icon(Icons.star, size: 50, color: Colors.orange),
            ),
            Positioned(
              bottom: 50,
              left: basketX,
              child: Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              child: Text(
                "Score: $score",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}