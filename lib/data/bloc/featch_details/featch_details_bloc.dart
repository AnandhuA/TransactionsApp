import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transaction_app/models/model.dart';
import 'package:transaction_app/network/featch_data.dart';

part 'featch_details_event.dart';
part 'featch_details_state.dart';

class FeatchDetailsBloc extends Bloc<FeatchDetailsEvent, FeatchDetailsState> {
  FeatchDetailsBloc() : super(FeatchDetailsInitial()) {
    on<FeatchAllDetailsEvent>((event, emit) async {
      emit(FeatchDetailsLoadingState());

      final AccountStatement? response = await FeatchData.featchData();

      if (response != null) {
        List<Transaction> allTransactions =
            response.account.transactions.transactionList;

        List<Transaction> creditTransactions = allTransactions
            .where((transaction) => transaction.type == 'CREDIT')
            .toList();
        List<Transaction> debitTransactions = allTransactions
            .where((transaction) => transaction.type == 'DEBIT')
            .toList();

        log('Credit transactions count: ${creditTransactions.length}');
        log('Debit transactions count: ${debitTransactions.length}');

        // Calculate total amounts for debit and credit transactions
        double totalDebitAmount = debitTransactions.fold(
            0.0, (sum, transaction) => sum + double.parse(transaction.amount));
        double totalCreditAmount = creditTransactions.fold(
            0.0, (sum, transaction) => sum + double.parse(transaction.amount));

        log('Total debit amount: $totalDebitAmount');
        log('Total credit amount: $totalCreditAmount');

        // Calculate total amount across both debit and credit transactions
        double totalAmount = totalDebitAmount + totalCreditAmount;

        // Calculate percentages for the daily pie chart sections
        List<PieChartSectionData> dailyPieChartSections = [
          PieChartSectionData(
            value: totalDebitAmount / totalAmount,
            title: 'DEBIT',
            color: Colors.red.shade300,
          ),
          PieChartSectionData(
            value: totalCreditAmount / totalAmount,
            title: 'CREDIT',
            color: Colors.green.shade300,
          ),
        ];

        // Calculate monthly transactions
        List<Transaction> monthlyTransactions = allTransactions
            .where((transaction) =>
                DateTime.parse(transaction.transactionTimestamp).month ==
                DateTime.now().month)
            .toList();

        double totalMonthlyDebitAmount = monthlyTransactions.fold(
            0.0,
            (sum, transaction) => transaction.type == 'DEBIT'
                ? sum + double.parse(transaction.amount)
                : sum);
        double totalMonthlyCreditAmount = monthlyTransactions.fold(
            0.0,
            (sum, transaction) => transaction.type == 'CREDIT'
                ? sum + double.parse(transaction.amount)
                : sum);

        // Calculate percentages for the monthly pie chart sections
        List<PieChartSectionData> monthlyPieChartSections = [
          PieChartSectionData(
            value: totalMonthlyDebitAmount /
                (totalMonthlyDebitAmount + totalMonthlyCreditAmount),
            title: 'DEBIT',
            color: Colors.red.shade300,
          ),
          PieChartSectionData(
            value: totalMonthlyCreditAmount /
                (totalMonthlyDebitAmount + totalMonthlyCreditAmount),
            title: 'CREDIT',
            color: Colors.green.shade300,
          ),
        ];

        // Calculate yearly transactions
        List<Transaction> yearlyTransactions = allTransactions
            .where((transaction) =>
                DateTime.parse(transaction.transactionTimestamp).year ==
                DateTime.now().year)
            .toList();

        double totalYearlyDebitAmount = yearlyTransactions.fold(
            0.0,
            (sum, transaction) => transaction.type == 'DEBIT'
                ? sum + double.parse(transaction.amount)
                : sum);
        double totalYearlyCreditAmount = yearlyTransactions.fold(
            0.0,
            (sum, transaction) => transaction.type == 'CREDIT'
                ? sum + double.parse(transaction.amount)
                : sum);

        // Calculate percentages for the yearly pie chart sections
        List<PieChartSectionData> yearlyPieChartSections = [
          PieChartSectionData(
            value: totalYearlyDebitAmount /
                (totalYearlyDebitAmount + totalYearlyCreditAmount),
            title: 'DEBIT',
            color: Colors.red.shade300,
          ),
          PieChartSectionData(
            value: totalYearlyCreditAmount /
                (totalYearlyDebitAmount + totalYearlyCreditAmount),
            title: 'CREDIT',
            color: Colors.green.shade300,
          ),
        ];

        return emit(FeatchDetailsSuccessState(
          statement: response,
          debitTransactions: debitTransactions,
          creditTransactions: creditTransactions,
          dailyPieChartSections: dailyPieChartSections,
          monthlyPieChartSections: monthlyPieChartSections,
          yearlyPieChartSections: yearlyPieChartSections,
          totalAmount: totalAmount,
          
        ));
      } else {
        return emit(FeatchDetailsErrorState());
      }
    });
  }
}
