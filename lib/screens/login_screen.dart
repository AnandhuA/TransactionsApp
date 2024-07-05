import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:transaction_app/core/colors.dart';
import 'package:transaction_app/core/const_size.dart';
import 'package:transaction_app/core/styles.dart';
import 'package:transaction_app/core/validation.dart';
import 'package:transaction_app/screens/sign_in_screen.dart';
import 'package:transaction_app/screens/widgets/text_feild.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
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
                  labelText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailcontroller,
                  validation: validateEmail,
                ),
                height20,
                TextFieldWidget(
                  labelText: "Password",
                  keyboardType: TextInputType.emailAddress,
                  controller: _passwordcontroller,
                  validation: validatePassword,
                  suffixIcon: true,
                ),
                height20,
                ElevatedButton(
                  style: elevatedButtonStyle,
                  onPressed: () {},
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: whiteColor,
                    ),
                  ),
                ),
                height20,
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      text: "Don't have an account?  ",
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign In',
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
                                  builder: (context) => SignInScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
