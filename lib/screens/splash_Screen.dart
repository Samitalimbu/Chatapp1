import 'dart:async';

import 'package:division/division.dart';
import 'package:firebase/screens/walkthrough_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 8), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => WalkthroughScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     const SystemUiOverlayStyle(statusBarColor: Colors.blue));
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
              ..padding(top: 476, horizontal: 120)
              ..textColor(Colors.white)
              ..fontSize(32),
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
