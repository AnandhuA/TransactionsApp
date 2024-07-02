import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transaction_app/data/bloc/featch_details/featch_details_bloc.dart';
import 'package:transaction_app/screens/widgets/transaction.dart';

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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: BlocBuilder<FeatchDetailsBloc, FeatchDetailsState>(
        builder: (context, state) {
          if (state is FeatchDetailsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FeatchDetailsSuccessState) {
            return TransactionWidget(
              transactions: state.statement.account.transactions,
              creditTransactions: state.creditTransactions,
              debitTransactions: state.debitTransactions,
            );
            // return ListView.builder(
            //   itemCount:
            //       state.statement.account.transactions.transactionList.length,
            //   itemBuilder: (context, index) {
            //     return ListTile(
            //       title: Text(
            //         state.statement.account.transactions.transactionList[index]
            //             .amount,
            //       ),
            //     );
            //   },
            // );
          } else {
            return const Center(
              child: Text("Error"),
            );
          }
        },
      ),
    );
  }
}
