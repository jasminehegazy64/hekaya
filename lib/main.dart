import 'package:hekaya/common/color_extension.dart';
import 'package:hekaya/view/main_tab/main_tab_view.dart';
import 'package:hekaya/view/onboarding/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:hekaya/utils/cache_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCb_40hHSGjh8XQfkczU37lN-3kym7IaWU',
          messagingSenderId: '4729022730',
          appId: '1:4729022730:android:56c80a223d78d14c0a32f3',
          projectId: 'hekaya-4ee34'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: TColor.primary,

        fontFamily: 'SF Pro Text',
      ),
      home: const OnboardingView(),
    );
  }
}
