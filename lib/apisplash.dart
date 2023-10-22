import 'dart:async';
import 'package:apifetch/apidata.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay to simulate a longer loading time
    Timer(Duration(seconds: 2), () {
      // After the delay, navigate to the main screen or any other screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Api(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Customize the background color if needed
      body: Center(
        child: RichText(text: TextSpan(
          children: [
            TextSpan(text: 'StepUp',style: TextStyle(color: Colors.black,fontSize: 22,fontWeight:FontWeight.bold)),
            TextSpan(text: 'News',style: TextStyle(color: Colors.blue,fontSize: 22,fontWeight: FontWeight.bold))
          ]
        ),
          // Customize the logo size if needed
        ),
      ),
    );
  }
}
