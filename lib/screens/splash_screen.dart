import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });

    _controller?.forward();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Opacity(
              opacity: _animation!.value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Fitness Tracker',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.tealAccent,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.teal,
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.tealAccent),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
