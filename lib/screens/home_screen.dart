// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:transaction_app/core/background.dart';
import 'package:transaction_app/core/const_size.dart';
import 'package:transaction_app/core/styles.dart';
import 'package:transaction_app/data/bloc/featch_details/featch_details_bloc.dart';
import 'package:transaction_app/screens/transaction_screen.dart';
import 'package:transaction_app/screens/widgets/card_widget.dart';
import 'package:transaction_app/screens/widgets/pi_graph.dart';

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
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => ProfileScreen(
                      //         statement: state.statement,
                      //       ),
                      //     ));
                    },
                    icon: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      state.statement.account.profile.holders.holder.name,
                      overflow: TextOverflow.fade,
                    ),
                  )
                ],
              ),
              actions: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.notifications)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.graphic_eq_sharp))
              ],
            ),
            body: Background(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        // onTap: () => Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) =>
                        //           ProfileScreen(statement: state.statement),
                        //     )),
                        child: CardWidget(
                          formattedBalance: formattedBalance,
                          statement: state.statement,
                        ),
                      ),
                      height20,
                      // ChartWidget(
                      //   dailyPieChartSections: state.dailyPieChartSections,
                      //   monthlyPieChartSections: state.monthlyPieChartSections,
                      //   yearlyPieChartSections: state.yearlyPieChartSections,
                      // ),
                      height20,

                      PigraphDetailsWidget(
                        electricity: state.totalElectricityTransationAmount,
                        others: state.totalOtherTransationAmount,
                        petrol: state.totalPeterolTransationAmount,
                        rent: state.totalRentTransationAmount,
                        salary: state.totalSalaryTransationAmount,
                        saveings: state.totalSavingsTransationAmount,
                      ),
                      height20,
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TransactionScreen(),
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
