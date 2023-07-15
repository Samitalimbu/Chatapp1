import 'dart:async';

import 'package:division/division.dart';
import 'package:firebase/components/walkthrough_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 8), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => WalkthroughScreen()));
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer if it's still active
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/splash2.jpg",
            fit: BoxFit.cover,
            height: 1200,
          ),
          Txt(
            "ChitChat",
            style: TxtStyle()
              ..fontWeight(FontWeight.bold)
              ..padding(top: 476, horizontal: 116)
              ..textColor(Colors.white)
              ..fontSize(30),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Txt(
              "Let us seize the opportunity to interact with one another, to listento sympathize, and to rejoice in the wonder of shared experiences.",
              style: TxtStyle()
                ..padding(top: 508, horizontal: 80)
                ..textColor(Colors.white)
                ..fontSize(15),
            ),
          )
        ],
      ),
    );
  }
}
