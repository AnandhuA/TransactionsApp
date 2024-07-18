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

        //-----------credit and debit transactions-----------------
        List<Transaction> creditTransactions = allTransactions
            .where((transaction) => transaction.type == 'CREDIT')
            .toList();
        List<Transaction> debitTransactions = allTransactions
            .where((transaction) => transaction.type == 'DEBIT')
            .toList();

        double totalDebitAmount = debitTransactions.fold(
            0.0, (sum, transaction) => sum + double.parse(transaction.amount));
        double totalCreditAmount = creditTransactions.fold(
            0.0, (sum, transaction) => sum + double.parse(transaction.amount));

        //-----------upi transactions-----------------
        List<Transaction> upiTransactions = allTransactions
            .where((transation) => transation.mode == "UPI")
            .toList();
        double totalUpiTransationAmount = upiTransactions.fold(
            0.0, (sum, transaction) => sum + double.parse(transaction.amount));

        //-----------other transactions-----------------
        List<Transaction> otherTransactions = allTransactions
            .where((transation) => transation.mode == "OTHERS")
            .toList();
        double totalOtherTransationAmount = otherTransactions.fold(
            0.0, (sum, transaction) => sum + double.parse(transaction.amount));

        //-----------salary transactions-----------------
        List<Transaction> salaryTransation =
            allTransactions.where((transaction) {
          return transaction.narration
              .toLowerCase()
              .contains("employee salary".toLowerCase());
        }).toList();
        double totalSalaryTransationAmount = salaryTransation.fold(
            0.0, (sum, transaction) => sum + double.parse(transaction.amount));

        //-----------bharatpe transactions-----------------
        List<Transaction> bharatpeTransation =
            allTransactions.where((transaction) {
          return transaction.narration
              .toLowerCase()
              .contains("BHARATPE".toLowerCase());
        }).toList();
        double totalBharatpeTransationAmount = bharatpeTransation.fold(
            0.0, (sum, transaction) => sum + double.parse(transaction.amount));

        //-----------electricity transactions-----------------
        List<Transaction> electricityTransation =
            allTransactions.where((transaction) {
          return transaction.narration
              .toLowerCase()
              .contains("Electricity".toLowerCase());
        }).toList();
        double totalElectricityTransationAmount = electricityTransation.fold(
            0.0, (sum, transaction) => sum + double.parse(transaction.amount));

        //-----------rent transactions----------------
        List<Transaction> rentTransation = allTransactions.where((transaction) {
          return transaction.narration
              .toLowerCase()
              .contains("Rent".toLowerCase());
        }).toList();
        double totalRentTransationAmount = rentTransation.fold(
            0.0, (sum, transaction) => sum + double.parse(transaction.amount));

        //-----------peterol transactions-----------------
        List<Transaction> peterolTransation =
            allTransactions.where((transaction) {
          return transaction.narration
              .toLowerCase()
              .contains("PETROLEUM".toLowerCase());
        }).toList();
        double totalPeterolTransationAmount = peterolTransation.fold(
            0.0, (sum, transaction) => sum + double.parse(transaction.amount));

        //-----------savings transactions-----------------
        List<Transaction> savingsTransation =
            allTransactions.where((transaction) {
          return transaction.narration
              .toLowerCase()
              .contains("MutualFunds".toLowerCase());
        }).toList();
        double totalSavingsTransationAmount = savingsTransation.fold(
            0.0, (sum, transaction) => sum + double.parse(transaction.amount));

        //----------- policy transactions-----------------
        List<Transaction> policyTransation =
            allTransactions.where((transaction) {
          return transaction.narration
              .toLowerCase()
              .contains("POLICYBAZAAR".toLowerCase());
        }).toList();
        double totalPolicyTransationAmount = policyTransation.fold(
            0.0, (sum, transaction) => sum + double.parse(transaction.amount));

        return emit(
          FeatchDetailsSuccessState(
            statement: response,
            debitTransactions: debitTransactions,
            creditTransactions: creditTransactions,
            totalDebitAmount: totalDebitAmount,
            totalCreditAmount: totalCreditAmount,
            totalUpiTransationAmount: totalUpiTransationAmount,
            upiTransactions: upiTransactions,
            otherTransactions: otherTransactions,
            totalOtherTransationAmount: totalOtherTransationAmount,
            salaryTransation: salaryTransation,
            totalSalaryTransationAmount: totalSalaryTransationAmount,
            bharatpeTransation: bharatpeTransation,
            totalBharatpeTransationAmount: totalBharatpeTransationAmount,
            electricityTransation: electricityTransation,
            totalElectricityTransationAmount: totalElectricityTransationAmount,
            rentTransation: rentTransation,
            totalRentTransationAmount: totalRentTransationAmount,
            peterolTransation: peterolTransation,
            totalPeterolTransationAmount: totalPeterolTransationAmount,
            savingsTransation: savingsTransation,
            totalSavingsTransationAmount: totalSavingsTransationAmount,
            policyTransation: policyTransation,
            totalPolicyTransationAmount: totalPolicyTransationAmount,
          ),
        );
      } else {
        return emit(FeatchDetailsErrorState());
      }
    });
    on<FeatchIteamWithDate>((event, emit) async {
      emit(FeatchDetailsLoadingState());
      print(event.date);
      final AccountStatement? response = await FeatchData.featchData();

      if (response != null) {
        List<Transaction> allTransactions =
            response.account.transactions.transactionList;
        final List<Transaction> transactionsWithDate =
            allTransactions.where((transaction) {
          // Convert transaction.valueDate to DateTime for comparison
          DateTime transactionDate = DateTime.parse(transaction.valueDate);

          return transactionDate.year == event.date.year &&
              transactionDate.month == event.date.month;
          // transactionDate.day == event.date.day;
        }).toList();
        emit(FeatchDetailsWithDate(
            listofTransactionswithDate: transactionsWithDate));
      } else {
        emit(FeatchDetailsErrorState());
      }
    });

    on<FeatchAnalyticsEvent>(
      (event, emit) async {
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

          double totalDebitAmount = debitTransactions.fold(0.0,
              (sum, transaction) => sum + double.parse(transaction.amount));
          double totalCreditAmount = creditTransactions.fold(0.0,
              (sum, transaction) => sum + double.parse(transaction.amount));

          List<Transaction> savingsTransation =
              allTransactions.where((transaction) {
            return transaction.narration
                .toLowerCase()
                .contains("MutualFunds".toLowerCase());
          }).toList();
          double totalSavingsTransationAmount = savingsTransation.fold(0.0,
              (sum, transaction) => sum + double.parse(transaction.amount));

          List<Transaction> policyTransation =
              allTransactions.where((transaction) {
            return transaction.narration
                .toLowerCase()
                .contains("POLICYBAZAAR".toLowerCase());
          }).toList();
          double totalPolicyTransationAmount = policyTransation.fold(0.0,
              (sum, transaction) => sum + double.parse(transaction.amount));
        }
      },
    );

    on<FeateHomeDetailsWithDate>(
      (event, emit) async {
        final AccountStatement? response = await FeatchData.featchData();

        if (response != null) {
          List<Transaction> allTransactions =
              response.account.transactions.transactionList;

          allTransactions = allTransactions.where((transaction) {
            final transactionDate = DateTime.parse(transaction.valueDate);
            return transactionDate.year == event.date.year &&
                transactionDate.month == event.date.month;
          }).toList();

          //-----------credit and debit transactions-----------------
          List<Transaction> creditTransactions = allTransactions
              .where((transaction) => transaction.type == 'CREDIT')
              .toList();
          List<Transaction> debitTransactions = allTransactions
              .where((transaction) => transaction.type == 'DEBIT')
              .toList();

          double totalDebitAmount = debitTransactions.fold(0.0,
              (sum, transaction) => sum + double.parse(transaction.amount));
          double totalCreditAmount = creditTransactions.fold(0.0,
              (sum, transaction) => sum + double.parse(transaction.amount));

          //-----------upi transactions-----------------
          List<Transaction> upiTransactions = allTransactions
              .where((transation) => transation.mode == "UPI")
              .toList();
          double totalUpiTransationAmount = upiTransactions.fold(0.0,
              (sum, transaction) => sum + double.parse(transaction.amount));

          //-----------other transactions-----------------
          List<Transaction> otherTransactions = allTransactions
              .where((transation) => transation.mode == "OTHERS")
              .toList();
          double totalOtherTransationAmount = otherTransactions.fold(0.0,
              (sum, transaction) => sum + double.parse(transaction.amount));

          //-----------salary transactions-----------------
          List<Transaction> salaryTransation =
              allTransactions.where((transaction) {
            return transaction.narration
                .toLowerCase()
                .contains("employee salary".toLowerCase());
          }).toList();
          double totalSalaryTransationAmount = salaryTransation.fold(0.0,
              (sum, transaction) => sum + double.parse(transaction.amount));

          //-----------bharatpe transactions-----------------
          List<Transaction> bharatpeTransation =
              allTransactions.where((transaction) {
            return transaction.narration
                .toLowerCase()
                .contains("BHARATPE".toLowerCase());
          }).toList();
          double totalBharatpeTransationAmount = bharatpeTransation.fold(0.0,
              (sum, transaction) => sum + double.parse(transaction.amount));

          //-----------electricity transactions-----------------
          List<Transaction> electricityTransation =
              allTransactions.where((transaction) {
            return transaction.narration
                .toLowerCase()
                .contains("Electricity".toLowerCase());
          }).toList();
          double totalElectricityTransationAmount = electricityTransation.fold(
              0.0,
              (sum, transaction) => sum + double.parse(transaction.amount));

          //-----------rent transactions----------------
          List<Transaction> rentTransation =
              allTransactions.where((transaction) {
            return transaction.narration
                .toLowerCase()
                .contains("Rent".toLowerCase());
          }).toList();
          double totalRentTransationAmount = rentTransation.fold(0.0,
              (sum, transaction) => sum + double.parse(transaction.amount));

          //-----------peterol transactions-----------------
          List<Transaction> peterolTransation =
              allTransactions.where((transaction) {
            return transaction.narration
                .toLowerCase()
                .contains("PETROLEUM".toLowerCase());
          }).toList();
          double totalPeterolTransationAmount = peterolTransation.fold(0.0,
              (sum, transaction) => sum + double.parse(transaction.amount));

          //-----------savings transactions-----------------
          List<Transaction> savingsTransation =
              allTransactions.where((transaction) {
            return transaction.narration
                .toLowerCase()
                .contains("MutualFunds".toLowerCase());
          }).toList();
          double totalSavingsTransationAmount = savingsTransation.fold(0.0,
              (sum, transaction) => sum + double.parse(transaction.amount));

          //----------- policy transactions-----------------
          List<Transaction> policyTransation =
              allTransactions.where((transaction) {
            return transaction.narration
                .toLowerCase()
                .contains("POLICYBAZAAR".toLowerCase());
          }).toList();
          double totalPolicyTransationAmount = policyTransation.fold(0.0,
              (sum, transaction) => sum + double.parse(transaction.amount));

          return emit(
            FeatchDetailsSuccessState(
              statement: response,
              debitTransactions: debitTransactions,
              creditTransactions: creditTransactions,
              totalDebitAmount: totalDebitAmount,
              totalCreditAmount: totalCreditAmount,
              totalUpiTransationAmount: totalUpiTransationAmount,
              upiTransactions: upiTransactions,
              otherTransactions: otherTransactions,
              totalOtherTransationAmount: totalOtherTransationAmount,
              salaryTransation: salaryTransation,
              totalSalaryTransationAmount: totalSalaryTransationAmount,
              bharatpeTransation: bharatpeTransation,
              totalBharatpeTransationAmount: totalBharatpeTransationAmount,
              electricityTransation: electricityTransation,
              totalElectricityTransationAmount:
                  totalElectricityTransationAmount,
              rentTransation: rentTransation,
              totalRentTransationAmount: totalRentTransationAmount,
              peterolTransation: peterolTransation,
              totalPeterolTransationAmount: totalPeterolTransationAmount,
              savingsTransation: savingsTransation,
              totalSavingsTransationAmount: totalSavingsTransationAmount,
              policyTransation: policyTransation,
              totalPolicyTransationAmount: totalPolicyTransationAmount,
            ),
          );
        } else {
          return emit(FeatchDetailsErrorState());
        }
      },
    );
  }
}
