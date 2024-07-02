import 'package:flutter/material.dart';
import 'package:transaction_app/models/model.dart';

class TransactionListView extends StatelessWidget {
  final List<Transaction> transactionList;
  const TransactionListView({super.key, required this.transactionList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(transactionList[index].type),
          trailing: transactionList[index].type == "DEBIT"
              ? Text("-${transactionList[index].amount}")
              : Text("+${transactionList[index].amount}"),
        );
      },
    );
  }
}
