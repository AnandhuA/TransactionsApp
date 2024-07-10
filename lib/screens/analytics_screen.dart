import 'package:flutter/material.dart';
import 'package:transaction_app/core/background.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Analytics'),
      ),
      body: Background(
        child: const Center(
          child: Text('Analytics'),
        ),
      ),
    );
  }
}
