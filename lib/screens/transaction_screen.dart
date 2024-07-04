import 'package:flutter/material.dart';
import 'package:transaction_app/models/model.dart';
import 'package:transaction_app/screens/widgets/transaction_list_view.dart';

class TransactionScreen extends StatelessWidget {
  final Transactions transactions;
  final List<Transaction> debitTransactions;
  final List<Transaction> creditTransactions;
  const TransactionScreen({
    super.key,
    required this.transactions,
    required this.debitTransactions,
    required this.creditTransactions,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transactions'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'CREDIT'),
              Tab(text: 'DEBIT'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TransactionListView(
              transactionList: transactions.transactionList,
            ),
            TransactionListView(
              transactionList: creditTransactions,
            ),
            TransactionListView(
              transactionList: debitTransactions,
            ),
          ],
        ),
      ),
    );
  }
}
