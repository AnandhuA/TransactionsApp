import 'package:flutter/material.dart';
import 'package:transaction_app/core/background.dart';

class TransationsScreen extends StatelessWidget {
  const TransationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Transactions'),
      ),
      body: Background(
        child: Center(
          child: Text(
            'Transactions',
          ),
        ),
      ),
    );
  }
}
