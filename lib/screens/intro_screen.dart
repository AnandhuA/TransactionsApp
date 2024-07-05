import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:transaction_app/core/background.dart';
import 'package:transaction_app/core/const_size.dart';
import 'package:transaction_app/core/styles.dart';
import 'package:transaction_app/screens/login_screen.dart';
import 'package:transaction_app/screens/sign_in_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Spacer(),
              Lottie.asset(
                "assets/intro.json",
                repeat: false,
              ),
              height35,
              ElevatedButton(
                style: elevatedButtonStyle,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              height20,
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account?  ",
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
