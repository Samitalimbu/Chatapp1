import 'package:division/division.dart';
import 'package:firebase/common_widgets/snack_show.dart';
import 'package:firebase/providers/auth_provider.dart';
import 'package:firebase/screens/aboutus_screen.dart';
import 'package:firebase/screens/edit_profile.dart';
import 'package:firebase/screens/help_screen.dart';
import 'package:firebase/screens/home.dart';
import 'package:firebase/screens/status_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../main.dart';
import '../models/post.dart';
import '../providers/room_provider.dart';
import '../services/auth_service.dart';
import '../services/post_service.dart';

class Mystatus extends ConsumerWidget {
  const Mystatus({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final postData = ref.watch(postStream);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: InkWell(
                    onTap: () {
                      Get.to(() => HomeScreen());
                    },
                    child: Icon(Icons.arrow_back_ios)),
              ),
              const Center(
                child: CircleAvatar(
                  radius: 70.0,
                  backgroundImage: AssetImage("assets/images/ok.png"),
                ),
              ),
              const SizedBox(height: 26),
              ListTile(
                title: Text(
                  "My Status",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(() => AboutusScreen());
                },
                title: Text(
                  "About US",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(() => HelpScreen());
                },
                title: Text(
                  "Help",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                ),
              ),
              ListTile(
                onTap: () async {
                  await ref
                      .read(authProvider.notifier)
                      .userLogout()
                      .then((value) =>
                          SnackShow.showSuccess(context, 'user logged out'))
                      .then((value) => Get.offAll(StatusPage()));
                  // Get.to(() => HelpScreen());
                },
                title: Text(
                  "Log out",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
