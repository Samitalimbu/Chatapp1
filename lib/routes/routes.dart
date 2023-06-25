import 'package:firebase/screens/create_page.dart';
import 'package:firebase/screens/home.dart';
import 'package:firebase/screens/recentchat_screen.dart';
import 'package:firebase/screens/signup_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import '../screens/splash_Screen.dart';
import '../screens/walkthrough_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411, 866),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => SplashScreen(),
              "/walkthrough": (context) => const WalkthroughScreen(),
              '/login': (context) => SignUpScreen(),
              '/dashboard': (context) => HomeScreen(),
              '/google': (context) => CreatePageScreen(),
              '/weardashboard': ((context) => RecentChats()),
            });
      },
    );
  }
}
