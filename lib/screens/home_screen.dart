// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:transaction_app/core/background.dart';
import 'package:transaction_app/core/const_size.dart';
import 'package:transaction_app/core/styles.dart';
import 'package:transaction_app/data/bloc/featch_details/featch_details_bloc.dart';
import 'package:transaction_app/screens/profile_screen.dart';
import 'package:transaction_app/screens/splash_screen.dart';
import 'package:transaction_app/screens/transaction_screen.dart';
import 'package:transaction_app/screens/widgets/chart_widget.dart';
import 'package:transaction_app/screens/widgets/confirmation_diloge.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<FeatchDetailsBloc>().add(FeatchAllDetailsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeatchDetailsBloc, FeatchDetailsState>(
      builder: (context, state) {
        if (state is FeatchDetailsSuccessState) {
          final formattedBalance = NumberFormat('#,##0.00').format(
              double.parse(state.statement.account.summary.currentBalance));

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              statement: state.statement,
                            ),
                          ));
                    },
                    icon: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  ),
                  Text(
                    state.statement.account.profile.holders.holder.name,
                  )
                ],
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      confirmationDiloge(
                        context: context,
                        title: "Confirm Logout",
                        confirmBtn: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SplashScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        content: "Are you sure you want to log out?",
                      );
                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
            body: Background(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProfileScreen(statement: state.statement),
                            )),
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            color: Colors.white.withOpacity(0.1),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                    width: 1.5,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Current Balance",
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            Text(
                                              "₹ $formattedBalance",
                                              style:
                                                  const TextStyle(fontSize: 30),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    height10,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "Type: ${state.statement.account.summary.type}",
                                        ),
                                        Text(
                                          "Status: ${state.statement.account.summary.status}",
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      height20,
                      ChartWidget(
                        dailyPieChartSections: state.dailyPieChartSections,
                        monthlyPieChartSections: state.monthlyPieChartSections,
                        yearlyPieChartSections: state.yearlyPieChartSections,
                      ),
                      height20,
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TransactionScreen(
                                  transactions:
                                      state.statement.account.transactions,
                                  debitTransactions: state.debitTransactions,
                                  creditTransactions: state.creditTransactions,
                                ),
                              ));
                        },
                        style: elevatedButtonStyle,
                        child: const Text("All Transactions"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is FeatchDetailsLoadingState) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            body: const Background(
                child: Center(
              child: CircularProgressIndicator(),
            )),
          );
        } else {
          return const Scaffold(
            body: Background(
              child: Center(
                child: Text("Error"),
              ),
            ),
          );
        }
      },
    );
  }
}
