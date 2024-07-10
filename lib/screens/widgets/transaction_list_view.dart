import 'package:flutter/material.dart';
import 'package:transaction_app/models/model.dart';
import 'package:transaction_app/screens/widgets/transation_tile.dart';

class TransactionListView extends StatelessWidget {
  final List<Transaction> transactionList;
  const TransactionListView({super.key, required this.transactionList});

  @override
  Widget build(BuildContext context) {
    return transactionList.isEmpty
        ? const Center(
            child: Text("No Data"),
          )
        : ListView.separated(
            itemCount: transactionList.length,
            itemBuilder: (context, index) {
              return ExpandableListTile(
                transation: transactionList[index],
              );
              // return ListTile(

              //   leading: CircleAvatar(
              //     child: transactionList[index].type == "DEBIT"
              //         ? const Icon(Icons.call_made_outlined)
              //         : const Icon(Icons.call_received),
              //   ),
              //   title: Text(transactionList[index].type),
              //   subtitle: Text(transactionList[index].mode),
              //   trailing: Column(
              //     children: [
              //       transactionList[index].type == "DEBIT"
              //           ? Text(
              //               "-${transactionList[index].amount}",
              //               style: const TextStyle(color: Colors.red, fontSize: 20),
              //             )
              //           : Text(
              //               "+${transactionList[index].amount}",
              //               style: const TextStyle(color: Colors.green, fontSize: 20),
              //             ),
              //       Text(formattedDateTime)
              //     ],
              //   ),
              // );
            },
            separatorBuilder: (context, index) => const Divider(),
          );
  }
}
