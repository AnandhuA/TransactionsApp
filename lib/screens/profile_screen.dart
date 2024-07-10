import 'package:flutter/material.dart';
import 'package:transaction_app/core/background.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Profile'),
      ),
      body: Background(
        child: Center(
          child: Text('Profile'),
        ),
      ),
    );
  }
}