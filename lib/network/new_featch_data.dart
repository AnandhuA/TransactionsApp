// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:transaction_app/models/model.dart';

class FeatchData {
  static Future<AccountStatement?> featchData() async {
    try {
      String jsonData = await rootBundle.loadString(
          'assets/json_data/1_fip_processed_da101fb0_periodic.json');
      final Map<String, dynamic> jsonMap = jsonDecode(jsonData);

      if (jsonMap.containsKey('BARB0KIMXXX')) {
        List<dynamic> accountData = jsonMap['BARB0KIMXXX'];

        if (accountData.isNotEmpty) {
          Map<String, dynamic> accountInfo = accountData.first;

          AccountStatement statements = AccountStatement.fromJson(accountInfo);

          return statements;
        } else {
          log('No data found.');
          return null;
        }
      } else {
        log('Key "BARB0KIMXXX" not found in JSON data.');
        return null;
      }
    } catch (e) {
      log('Error reading or parsing JSON: $e');
      return null;
    }
  }
}

// List<Transaction> filterTransactions({
//   String? type,
//   String? mode,
//   String? keyword,
// }) {
//   return transactionList.where((transaction) {
//     final matchesType = type == null || transaction.type == type;
//     final matchesMode = mode == null || transaction.mode == mode;
//     final matchesKeyword = keyword == null ||
//         transaction.narration.toLowerCase().contains(keyword.toLowerCase());
//     return matchesType && matchesMode && matchesKeyword;
//   }).toList();
// }

void featch() async {
  final AccountStatement? accountStatementModel = await FeatchData.featchData();
  if (accountStatementModel != null) {
    //-----------all transactions-----------------
    List<Transaction> allTransactions =
        accountStatementModel.account.transactions.transactionList;

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
    List<Transaction> salaryTransation = allTransactions.where((transaction) {
      return transaction.narration
          .toLowerCase()
          .contains("employee salary".toLowerCase());
    }).toList();
    double totalSalaryTransationAmount = salaryTransation.fold(
        0.0, (sum, transaction) => sum + double.parse(transaction.amount));

    //-----------bharatpe transactions-----------------
    List<Transaction> bharatpeTransation = allTransactions.where((transaction) {
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
      return transaction.narration.toLowerCase().contains("Rent".toLowerCase());
    }).toList();
    double totalRentTransationAmount = rentTransation.fold(
        0.0, (sum, transaction) => sum + double.parse(transaction.amount));

    //-----------peterol transactions-----------------
    List<Transaction> peterolTransation = allTransactions.where((transaction) {
      return transaction.narration
          .toLowerCase()
          .contains("PETROLEUM".toLowerCase());
    }).toList();
    double totalPeterolTransationAmount = peterolTransation.fold(
        0.0, (sum, transaction) => sum + double.parse(transaction.amount));

    //-----------savings transactions-----------------
    List<Transaction> savingsTransation = allTransactions.where((transaction) {
      return transaction.narration
          .toLowerCase()
          .contains("MutualFunds".toLowerCase());
    }).toList();
    double totalSavingsTransationAmount = savingsTransation.fold(
        0.0, (sum, transaction) => sum + double.parse(transaction.amount));

    //----------- policy transactions-----------------
    List<Transaction> policyTransation = allTransactions.where((transaction) {
      return transaction.narration
          .toLowerCase()
          .contains("POLICYBAZAAR".toLowerCase());
    }).toList();
    double totalPolicyTransationAmount = policyTransation.fold(
        0.0, (sum, transaction) => sum + double.parse(transaction.amount));

    log("bharatpe:${bharatpeTransation.length.toString()}");
    log("electricity:${electricityTransation.length.toString()}");
    log("salary:${salaryTransation.length.toString()}");
    log("other:${otherTransactions.length.toString()}");
    log("upi:${upiTransactions.length.toString()}");
    log("credit:${creditTransactions.length.toString()}");
    log("debit:${debitTransactions.length.toString()}");
    log("rent:${rentTransation.length.toString()}");
    log("peterol:${peterolTransation.length.toString()}");
    log("savings:${savingsTransation.length.toString()}");
    log("policy:${policyTransation.length.toString()}");
    log("all:${allTransactions.length.toString()}");
    log("totalDebitAmount:${totalDebitAmount.toString()}");
    log("totalCreditAmount:${totalCreditAmount.toString()}");
    log("totalUpiTransationAmount:${totalUpiTransationAmount.toString()}");
    log("totalOtherTransationAmount:${totalOtherTransationAmount.toString()}");
    log("totalSalaryTransationAmount:${totalSalaryTransationAmount.toString()}");
    log("totalBharatpeTransationAmount:${totalBharatpeTransationAmount.toString()}");
    log("totalElectricityTransationAmount:${totalElectricityTransationAmount.toString()}");
    log("totalRentTransationAmount:${totalRentTransationAmount.toString()}");
    log("totalPeterolTransationAmount:${totalPeterolTransationAmount.toString()}");
    log("totalSavingsTransationAmount:${totalSavingsTransationAmount.toString()}");
    log("totalPolicyTransationAmount:${totalPolicyTransationAmount.toString()}");

//[log] bharatpe:23
// [log] electricity:12
// [log] salary:12
// [log] other:50
// [log] upi:67
// [log] credit:21
// [log] debit:101
// [log] rent:12
// [log] peterol:14
// [log] savings:12
// [log] policy:12
// [log] all:122
// [log] totalDebitAmount:401080.0
// [log] totalCreditAmount:400900.0
// [log] totalUpiTransationAmount:197620.0
// [log] totalOtherTransationAmount:562360.0
// [log] totalSalaryTransationAmount:360000.0
// [log] totalBharatpeTransationAmount:12970.0
// [log] totalElectricityTransationAmount:13150.0
// [log] totalRentTransationAmount:96000.0
// [log] totalPeterolTransationAmount:10300.0
// [log] totalSavingsTransationAmount:30000.0
// [log] totalPolicyTransationAmount:30000.0
  }
}
