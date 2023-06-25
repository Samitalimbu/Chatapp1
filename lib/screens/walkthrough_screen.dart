import 'package:firebase/screens/signup_Screen.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({Key? key}) : super(key: key);

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 3;
              });
            },
            children: [
              buildPage(
                  title: "Welcome to Mero Health",
                  desc:
                      "Make friends by connecting with the world \n and share your happiness each other!",
                  image: "assets/images/walthrough_1.png"),
              buildPage(
                  title: "Instant Video Consultation",
                  desc:
                      "Chat with new strangers and make them \n your partners",
                  image: "assets/images/walkthrough_2.png"),
              buildPage(
                  title: "Doctor Video Consultation",
                  desc: "Choose your partners of same interests",
                  image: "assets/images/walkthrough_3.png"),
              buildPage(
                  title: "Get Prescription",
                  desc:
                      "Chat with new strangers and make them \n your partners",
                  image: "assets/images/walthrough_1.png"),
            ],
          ),
        ),
        bottomSheet: isLastPage
            ? Padding(
                padding: EdgeInsets.fromLTRB(60, 0, 60, 10),
                child: InkWell(
                    onTap: () {
                      Get.to(() => SignUpScreen());
                    },
                    child: Text("data")))
            : Container(
                height: 80,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          controller.jumpToPage(3);
                        },
                        child: const Text(
                          "SKIP",
                          style: TextStyle(color: Colors.grey),
                        )),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 4,
                        effect: WormEffect(
                            spacing: 16,
                            dotColor: Colors.grey.shade300,
                            activeDotColor: Colors.red),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                        child: const Text("NEXT")),
                  ],
                ),
              ),
      ),
    );
  }
}

Widget buildPage({
  required String title,
  required String desc,
  required String image,
}) =>
    Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            color: Colors.red,
            height: 430,
            width: 200,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Positioned(
          top: 150,
          left: 50,
          child: Container(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              height: 350,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Positioned(
          top: 520,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              desc,
              style: const TextStyle(
                  fontSize: 18, color: Color.fromARGB(255, 134, 119, 119)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
