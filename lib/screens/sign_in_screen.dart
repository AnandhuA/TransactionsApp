import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:transaction_app/core/colors.dart';
import 'package:transaction_app/core/const_size.dart';
import 'package:transaction_app/core/styles.dart';
import 'package:transaction_app/core/validation.dart';
import 'package:transaction_app/screens/login_screen.dart';
import 'package:transaction_app/screens/widgets/text_feild.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
              child: Column(
            children: [
              TextFieldWidget(
                labelText: "Name",
                keyboardType: TextInputType.emailAddress,
                controller: _nameController,
                validation: validateName,
              ),
              height20,
              TextFieldWidget(
                labelText: "Email",
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validation: validateEmail,
              ),
              height20,
              TextFieldWidget(
                labelText: "Password",
                keyboardType: TextInputType.emailAddress,
                controller: _passwordController,
                validation: validatePassword,
                suffixIcon: true,
              ),
              height20,
              ElevatedButton(
                style: elevatedButtonStyle,
                onPressed: () {},
                child: const Text(
                  "Sign In",
                  style: TextStyle(color: whiteColor),
                ),
              ),
              height20,
              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    text: "Already have an account?  ",
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          color: Colors.black,
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
              height30
            ],
          )),
        ),
      ),
    );
  }
}
