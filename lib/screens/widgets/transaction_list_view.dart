import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transaction_app/models/model.dart';

class TransactionListView extends StatelessWidget {
  final List<Transaction> transactionList;
  const TransactionListView({super.key, required this.transactionList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: transactionList.length,
      itemBuilder: (context, index) {
        DateTime dateTime =
            DateTime.parse(transactionList[index].transactionTimestamp);
        String formattedDateTime = DateFormat.yMMMd().format(dateTime);
        return ListTile(
          title: Text(transactionList[index].type),
          subtitle: Text(transactionList[index].mode),
          trailing: Column(
            children: [
              transactionList[index].type == "DEBIT"
                  ? Text(
                      "-${transactionList[index].amount}",
                      style: const TextStyle(color: Colors.red, fontSize: 20),
                    )
                  : Text(
                      "+${transactionList[index].amount}",
                      style: const TextStyle(color: Colors.green, fontSize: 20),
                    ),
              Text(formattedDateTime)
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
