import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:transaction_app/core/colors.dart';
import 'package:transaction_app/core/const_size.dart';
import 'package:transaction_app/core/styles.dart';
import 'package:transaction_app/data/bloc/featch_details/featch_details_bloc.dart';
import 'package:transaction_app/screens/profile_screen.dart';
import 'package:transaction_app/screens/transaction_screen.dart';
import 'package:transaction_app/screens/widgets/chart_widget.dart';

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
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Current Balance",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Text(
                                    "₹ $formattedBalance",
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          height10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Type:${state.statement.account.summary.type}",
                              ),
                              Text(
                                "Status:${state.statement.account.summary.status}",
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    height20,
                    // SizedBox(
                    //   height: 300,
                    //   child: ListView(
                    //     scrollDirection: Axis.horizontal,
                    //     children: [
                    //       _buildPieChart(state.dailyPieChartSections, 'Daily'),
                    //       _buildPieChart(
                    //           state.monthlyPieChartSections, 'Monthly'),
                    //       _buildPieChart(
                    //           state.yearlyPieChartSections, 'Yearly'),
                    //     ],
                    //   ),
                    // ),

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
          );
        } else if (state is FeatchDetailsLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text("Error"),
            ),
          );
        }
      },
    );
  }


}
