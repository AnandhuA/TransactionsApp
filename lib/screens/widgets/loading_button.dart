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
          "assets/Animation - 1717335743071.json",
          width: 80,
        ),
      ),
    );
  }
}
