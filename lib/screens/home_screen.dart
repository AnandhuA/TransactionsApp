import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transaction_app/data/bloc/featch_details/featch_details_bloc.dart';
import 'package:transaction_app/screens/profile_screen.dart';
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
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ));
            },
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
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(30),
                  padding: const EdgeInsets.all(20),
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Balance",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        state.statement.account.summary.currentBalance,
                        style: const TextStyle(fontSize: 30),
                      ),
                      Text("Type:${state.statement.account.summary.type}"),
                      Text("Type:${state.statement.account.summary.status}")
                    ],
                  ),
                ),
                Expanded(
                  child: TransactionWidget(
                    transactions: state.statement.account.transactions,
                    creditTransactions: state.creditTransactions,
                    debitTransactions: state.debitTransactions,
                  ),
                ),
              ],
            );
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
