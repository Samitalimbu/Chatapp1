import 'package:division/division.dart';
import 'package:firebase/screens/signup_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password resent link sent Check your email'),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    Get.to(() => SignUpScreen());
                  },
                  child: const Icon(Icons.arrow_back_ios)),
            ),
            Txt("Reset Password",
                style: TxtStyle()
                  ..fontWeight(FontWeight.bold)
                  ..fontSize(18)
                  ..alignmentContent.center()
                  ..alignmentContent.center(true)),
            const SizedBox(height: 200),
            Txt(
              "Receive an email to reset your password",
              style: TxtStyle()
                ..fontWeight(FontWeight.bold)
                ..fontSize(32)
                ..padding(left: 32),
            ),
            const SizedBox(height: 30),
            Txt(
              "Email",
              style: TxtStyle()
                ..fontWeight(FontWeight.w400)
                ..padding(left: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 64,
                decoration: BoxDecoration(
                    color: const Color(0xffD9D9D9),
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(143, 148, 251, .2),
                          blurRadius: 20.0,
                          offset: Offset(0, 10))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Write your email",
                      prefixIcon: Icon(Icons.mail),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: ElevatedButton(
                onPressed: passwordReset,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 116.0, vertical: 20.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    primary: Color.fromARGB(255, 192, 187, 187)),
                child: const InkWell(
                  child: Text(
                    "Reset Password ",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
