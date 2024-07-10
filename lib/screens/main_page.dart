import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transaction_app/data/bloc/bottam_navigation/bottam_navigation_bloc.dart';
import 'package:transaction_app/screens/analytics_screen.dart';
import 'package:transaction_app/screens/home_screen.dart';
import 'package:transaction_app/screens/profile_screen.dart';
import 'package:transaction_app/screens/transations_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static final List<Widget> screens = [
    const HomeScreen(),
    const TransationsScreen(),
    const AnalyticsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottamNavigationBloc, BottamNavigationState>(
        builder: (context, state) {
          return screens[state.currentIndex];
        },
      ),
      bottomNavigationBar:
          BlocBuilder<BottamNavigationBloc, BottamNavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            currentIndex: state.currentIndex,
            enableFeedback: true,
            onTap: (index) {
              context.read<BottamNavigationBloc>().add(TabChanged(index));
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wallet),
                label: "Transactions",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics),
                label: "Analytics",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          );
        },
      ),
    );
  }
}
