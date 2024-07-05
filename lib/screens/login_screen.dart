import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transaction_app/core/background.dart';
import 'package:transaction_app/core/colors.dart';
import 'package:transaction_app/core/const_size.dart';
import 'package:transaction_app/core/styles.dart';
import 'package:transaction_app/core/validation.dart';
import 'package:transaction_app/data/bloc/autentication/authentication_bloc.dart';
import 'package:transaction_app/screens/home_screen.dart';
import 'package:transaction_app/screens/sign_in_screen.dart';
import 'package:transaction_app/screens/widgets/custom_snack_bar.dart';
import 'package:transaction_app/screens/widgets/loading_button.dart';
import 'package:transaction_app/screens/widgets/text_feild.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationErrorState) {
            customSnackbar(
                context: context, message: state.error, color: errorColor);
          }
          if (state is AuthenticationSuccessState) {
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
          return Background(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        height35,
                        const Text(
                          "LogIn",
                          style:  TextStyle(fontSize: 100),
                        ),
                        height35,
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
                        state is AuthenticationLoadingState
                            ? const LoadingButton()
                            : ElevatedButton(
                                style: elevatedButtonStyle,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthenticationBloc>().add(
                                          LoginEvent(
                                            email: _emailcontroller.text,
                                            password: _passwordcontroller.text,
                                          ),
                                        );
                                  }
                                },
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
                              text: "Don't have an account?  ",
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Sign In',
                                  style: const TextStyle(
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
            ),
          );
        },
      ),
    );
  }
}
