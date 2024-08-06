import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kelpet/constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();

    // Start the fade-out animation after a delay
    Timer(Duration(seconds: 3), () {
      setState(() {
        _visible = false;
      });

      // Navigate to the home page after the fade-out is complete
      Timer(Duration(seconds: 1), () {
        context.go("/");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: Duration(seconds: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/splash.jpg'),
              SizedBox(height: 20), // Add some spacing
              Text(
                "Kelpet",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 40, 
                  color: secondary,
                  shadows: [
                    Shadow(
                      offset: Offset(3.0, 3.0),
                      color: Colors.black.withOpacity(0.3), 
                      blurRadius: 6.0, 
                    ),
                    Shadow(
                      offset: Offset(-1.0, -1.0),
                      color: Colors.black.withOpacity(0.3), 
                      blurRadius: 3.0, 
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
