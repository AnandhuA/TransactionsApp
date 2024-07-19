import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:transaction_app/core/background.dart';
import 'package:transaction_app/core/colors.dart';
import 'package:transaction_app/core/const_size.dart';
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
  DateTime? selectedMonth;

  @override
  void initState() {
    super.initState();
    context.read<FeatchDetailsBloc>().add(FeatchAllDetailsEvent());
  }

  // void _pickMonth() async {
  //   final pickedMonth = await showMonthYearPicker(
  //     context: context,
  //     initialDate: selectedMonth ?? DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime.now(),
  //   );

  //   if (pickedMonth != null) {
  //     setState(() {
  //       selectedMonth = pickedMonth;
  //     });
  //     if (selectedMonth != null) {
  //       context
  //           .read<FeatchDetailsBloc>()
  //           .add(FeatchIteamWithDate(date: selectedMonth ?? DateTime.now()));
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('$selectedTab Transactions'),
          actions: [
            // IconButton(
            //   onPressed: _pickMonth,
            //   icon: Row(
            //     children: [
            //       selectedMonth == null
            //           ? const Text("")
            //           : Text(DateFormat.yMMMM().format(selectedMonth!)),
            //       width10,
            //       const Icon(
            //         Icons.calendar_today,
            //       ),
            //     ],
            //   ),
            // ),
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
            // buildWhen: (previous, current) {
            //   return current is FeatchDetailsSuccessState ||
            //       current is FeatchDetailsWithDate ||
            //       current is FeatchDetailsLoadingState;
            // },
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
                log("screen:${state.listofTransactionswithDate.length.toString()}");
                return TransactionListView(
                  transactionList: state.listofTransactionswithDate,
                );
              } else {
                return Center(
                  child: Lottie.asset("assets/loadingscreen.json", width: 200),
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
              _buildCategoryRadioButton(context, 'All', setState),
              _buildCategoryRadioButton(context, 'Credit', setState),
              _buildCategoryRadioButton(context, 'Debit', setState),
              _buildCategoryRadioButton(context, 'UPI', setState),
              _buildCategoryRadioButton(context, 'Salary', setState),
              _buildCategoryRadioButton(context, 'Petrol', setState),
              _buildCategoryRadioButton(context, 'Electricity', setState),
              _buildCategoryRadioButton(context, 'Savings', setState),
              _buildCategoryRadioButton(context, 'Others', setState),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryRadioButton(
      BuildContext context, String category, StateSetter setState) {
    return RadioListTile(
      title: Text(category),
      value: category,
      groupValue: selectedTab,
      onChanged: (String? value) {
        Navigator.pop(context); // Close the bottom sheet
        setState(() {
          selectedTab = value!;
        });
      },
    );
  }
}
