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
}
