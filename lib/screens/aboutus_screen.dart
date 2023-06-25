import 'package:division/division.dart';
import 'package:firebase/screens/mystatus_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class AboutusScreen extends StatelessWidget {
  const AboutusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: const Color(0xfff6f6f6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: InkWell(
                      onTap: () {
                        Get.to(() => Mystatus());
                      },
                      child: Icon(Icons.arrow_back_ios)),
                ),
                Txt(
                  "About Us",
                  style: TxtStyle()
                    ..fontSize(22)
                    ..fontWeight(FontWeight.bold)
                    ..alignmentContent.center(true),
                ),
                Image.asset("assets/images/ok.png"),
                Txt(
                  "Welcome to Chitchat, the ultimate chat app designed to connect people and foster meaningful conversations. We believe in the power of communication and the ability to bring individuals from all walks of life together in a vibrant online community",
                  style: TxtStyle()
                    ..fontSize(14)
                    ..padding(all: 12)
                    ..fontWeight(FontWeight.w400)
                    ..alignmentContent.center(true),
                ),
                Image.asset("assets/images/ok2.png"),
                Txt(
                  "Our mission is to provide a platform where users can engage in engaging discussions, share ideas, and form lasting connections. Whether you're passionate about sports, art, technology, or any other topic, Chitchat offers a diverse range of chat rooms where you can connect with like-minded individuals and explore your interests",
                  style: TxtStyle()
                    ..fontSize(14)
                    ..padding(all: 12)
                    ..fontWeight(FontWeight.w400)
                    ..alignmentContent.center(true),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
