import 'package:division/division.dart';
import 'package:firebase/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          CupertinoPageRoute(builder: (_) => Setting()));
                    },
                    child: const Icon(Icons.arrow_back_ios)),
              ),
              Txt(
                "Help Section",
                style: TxtStyle()
                  ..fontSize(22)
                  ..fontWeight(FontWeight.bold)
                  ..alignmentContent.center(true),
              ),
              Image.asset("assets/images/help.png"),
              SizedBox(height: 20),
              Row(
                children: [
                  Image.asset("assets/images/full.png"),
                  Txt(
                    "Clearly communicate how user feedback is reviewed and \n considered for future updates",
                    style: TxtStyle()
                      ..fontSize(12)
                      ..fontWeight(FontWeight.w400)
                      ..alignmentContent.center(true),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Image.asset("assets/images/full.png"),
                  Txt(
                    " Provide information on response times and support hours \n to manage user expectations.",
                    style: TxtStyle()
                      ..fontSize(12)
                      ..fontWeight(FontWeight.w400)
                      ..alignmentContent.center(true),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Image.asset("assets/images/full.png"),
                  Txt(
                    " Provide a list of frequently asked questions and their answers \n related to the app's features, functionality, and common issues",
                    style: TxtStyle()
                      ..fontSize(12)
                      ..fontWeight(FontWeight.w400)
                      ..alignmentContent.center(true),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Image.asset("assets/images/full.png"),
                  Txt(
                    "Keep users informed about any upcoming events, promotions, \n or important announcements related to the app",
                    style: TxtStyle()
                      ..fontSize(12)
                      ..fontWeight(FontWeight.w400)
                      ..alignmentContent.center(true),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Image.asset("assets/images/full.png"),
                  Txt(
                    " Educate users on the consequences of violating the  \n guidelines  and the steps taken to maintain \n a positive and safe user environment",
                    style: TxtStyle()
                      ..fontSize(12)
                      ..fontWeight(FontWeight.w400)
                      ..alignmentContent.center(true),
                  ),
                ],
              ),
              SizedBox(height: 22),
              Txt(
                "Thank You!",
                style: TxtStyle()
                  ..fontSize(22)
                  ..fontWeight(FontWeight.bold)
                  ..textColor(Colors.blue)
                  ..alignmentContent.center(true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
