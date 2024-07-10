import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transaction_app/core/background.dart';
import 'package:transaction_app/core/colors.dart';
import 'package:transaction_app/data/bloc/featch_details/featch_details_bloc.dart';
import 'package:transaction_app/screens/widgets/transaction_list_view.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Transactions'),
          actions: [
            PopupMenuButton<String>(
              onSelected: (String result) {
                DateTime selectedDate = DateTime.now();
                switch (result) {
                  case 'This Month':
                    selectedDate = DateTime.now();
                    break;
                  case 'Previous Month':
                    selectedDate =
                        DateTime.now().subtract(const Duration(days: 30));
                    break;
                  case 'This Year':
                    selectedDate = DateTime(DateTime.now().year, 1, 1);
                    break;
                  case 'Previous Year':
                    selectedDate = DateTime(DateTime.now().year - 1, 1, 1);
                    break;

                  case 'All':
                    context
                        .read<FeatchDetailsBloc>()
                        .add(FeatchAllDetailsEvent());
                    return;
                }

                context.read<FeatchDetailsBloc>().add(FeatchIteamWithDate(
                      date: selectedDate,
                    ));
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'All',
                  child: Text('All'),
                ),
                const PopupMenuItem<String>(
                  value: 'This Month',
                  child: Text('This Month'),
                ),
                const PopupMenuItem<String>(
                  value: 'Previous Month',
                  child: Text('Previous Month'),
                ),
                const PopupMenuItem<String>(
                  value: 'This Year',
                  child: Text('This Year'),
                ),
              ],
            ),
            // IconButton(
            //   icon: const Icon(Icons.calendar_today),
            //   onPressed: () async {
            //     final DateTime? pickedDate = await showDatePicker(
            //       context: context,
            //       initialDate: DateTime.now(),
            //       firstDate: DateTime(2000),
            //       lastDate: DateTime.now(),
            //     );
            //     if (pickedDate != null) {

            //       context.read<FeatchDetailsBloc>().add(FeatchIteamWithDate(
            //             date: pickedDate,
            //           ));
            //     }
            //   },
            // ),
          ],
          bottom: const TabBar(
            indicatorColor: primaryColor,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'CREDIT'),
              Tab(text: 'DEBIT'),
            ],
          ),
        ),
        body: Background(
          child: BlocBuilder<FeatchDetailsBloc, FeatchDetailsState>(
            buildWhen: (previous, current) {
              return current is FeatchDetailsSuccessState ||
                  current is FeatchDetailsWithDate ||
                  current is FeatchDetailsLoadingState;
            },
            builder: (context, state) {
              if (state is FeatchDetailsSuccessState) {
                return TabBarView(
                  children: [
                    TransactionListView(
                      transactionList:
                          state.statement.account.transactions.transactionList,
                    ),
                    TransactionListView(
                      transactionList: state.creditTransactions,
                    ),
                    TransactionListView(
                      transactionList: state.debitTransactions,
                    ),
                  ],
                );
              } else if (state is FeatchDetailsWithDate) {
                return TransactionListView(
                    transactionList: state.listofTransactionswithDate);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              // return TabBarView(
              //   children: [
              //     TransactionListView(
              //       transactionList: transactions.transactionList,
              //     ),
              //     TransactionListView(
              //       transactionList: creditTransactions,
              //     ),
              //     TransactionListView(
              //       transactionList: debitTransactions,
              //     ),
              //   ],
              // );
            },
          ),
        ),
      ),
    );
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime.now(),
  //   );
  //   log("message");
  //   if (pickedDate != null) {
  //     context.read<FeatchDetailsBloc>().add(FeatchIteamWithDate(
  //           date: pickedDate,
  //         ));
  //   }
  // }
}
