

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transaction_app/core/background.dart';
import 'package:transaction_app/data/bloc/featch_details/featch_details_bloc.dart';
import 'package:transaction_app/screens/widgets/transaction_list_view.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({
    super.key,
  });

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String selectedTab = 'All';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('$selectedTab Transactions'),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                _showCategoryFilterModal(context);
              },
            ),
         
        
          ],
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
                switch (selectedTab) {
                  case 'All':
                    return TransactionListView(
                      transactionList:
                          state.statement.account.transactions.transactionList,
                    );
                  case 'Credit':
                    return TransactionListView(
                      transactionList: state.creditTransactions,
                    );
                  case 'Debit':
                    return TransactionListView(
                      transactionList: state.debitTransactions,
                    );
                  case 'UPI':
                    return TransactionListView(
                      transactionList: state.upiTransactions,
                    );
                  case 'Salary':
                    return TransactionListView(
                      transactionList: state.salaryTransation,
                    );
                  case 'Petrol':
                    return TransactionListView(
                      transactionList: state.peterolTransation,
                    );

                  case 'Electricity':
                    return TransactionListView(
                      transactionList: state.electricityTransation,
                    );
                  case 'Savings':
                    return TransactionListView(
                      transactionList: state.savingsTransation,
                    );
                  case 'Others':
                    return TransactionListView(
                      transactionList: state.otherTransactions,
                    );
                  default:
                    return const SizedBox.shrink();
                }
              } else if (state is FeatchDetailsWithDate) {
                return TransactionListView(
                  transactionList: state.listofTransactionswithDate,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _showCategoryFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter by Category',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildCategoryButton(context, 'All'),
              _buildCategoryButton(context, 'Credit'),
              _buildCategoryButton(context, 'Debit'),
              _buildCategoryButton(context, 'UPI'),
              _buildCategoryButton(context, 'Salary'),
              _buildCategoryButton(context, 'Petrol'),
              _buildCategoryButton(context, 'Electricity'),
              _buildCategoryButton(context, 'Savings'),
              _buildCategoryButton(context, 'Others'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryButton(BuildContext context, String category) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context); // Close the bottom sheet
        setState(() {
          selectedTab = category;
        });
      },
      child: Text(category),
    );
  }
}
