import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transaction_app/core/colors.dart';
import 'package:transaction_app/core/const_size.dart';
import 'package:transaction_app/core/styles.dart';
import 'package:transaction_app/core/validation.dart';
import 'package:transaction_app/data/bloc/autentication/authentication_bloc.dart';
import 'package:transaction_app/screens/home_screen.dart';
import 'package:transaction_app/screens/login_screen.dart';
import 'package:transaction_app/screens/widgets/custom_snack_bar.dart';
import 'package:transaction_app/screens/widgets/loading_button.dart';
import 'package:transaction_app/screens/widgets/text_feild.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationErrorState) {
            customSnackbar(
                context: context, message: state.error, color: errorColor);
          } else if (state is AuthenticationSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
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
                      state is AuthenticationLoadingState
                          ? const LoadingButton()
                          : ElevatedButton(
                              style: elevatedButtonStyle,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthenticationBloc>().add(
                                        SignUpEvent(
                                            name: _nameController.text,
                                            email: _emailController.text,
                                            password: _passwordController.text),
                                      );
                                }
                              },
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
          );
        },
      ),
    );
  }
}
