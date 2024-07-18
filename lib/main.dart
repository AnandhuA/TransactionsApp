import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:transaction_app/data/bloc/autentication/authentication_bloc.dart';
import 'package:transaction_app/data/bloc/bottam_navigation/bottam_navigation_bloc.dart';
import 'package:transaction_app/data/bloc/featch_details/featch_details_bloc.dart';
import 'package:transaction_app/firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:transaction_app/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeatchDetailsBloc>(
            create: (context) => FeatchDetailsBloc()),
        BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc()),
        BlocProvider<BottamNavigationBloc>(
            create: (context) => BottamNavigationBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
        ],
      ),
    );
  }
}
