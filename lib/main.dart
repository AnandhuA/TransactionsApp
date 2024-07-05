import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transaction_app/core/theme.dart';
import 'package:transaction_app/data/bloc/featch_details/featch_details_bloc.dart';

import 'package:transaction_app/screens/home_screen.dart';
import 'package:transaction_app/screens/intro_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FeatchDetailsBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const IntroScreen(),
      ),
    );
  }
}
