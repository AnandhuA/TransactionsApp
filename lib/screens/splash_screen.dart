import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:transaction_app/core/background.dart';
import 'package:transaction_app/screens/intro_screen.dart';
import 'package:transaction_app/screens/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goToSignup();
    // featchProductes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: Lottie.asset("assets/splash.json"),
        ),
      ),
    );
  }

  void goToSignup() async {
    Timer(const Duration(seconds: 2), () {
      final firebaseAuth = FirebaseAuth.instance;

      if (firebaseAuth.currentUser == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const IntroScreen(),
          ),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ),
          (route) => false,
        );
      }
    });
  }
}
