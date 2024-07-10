import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:transaction_app/core/styles.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: elevatedButtonStyle,
        child: Lottie.asset(
          "assets/loading (2).json",
          width: 80,
        ),
      ),
    );
  }
}
