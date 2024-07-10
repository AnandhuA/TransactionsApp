part of 'featch_details_bloc.dart';

@immutable
sealed class FeatchDetailsState {}

final class FeatchDetailsInitial extends FeatchDetailsState {}

final class FeatchDetailsLoadingState extends FeatchDetailsState {}

final class FeatchDetailsSuccessState extends FeatchDetailsState {
  final AccountStatement statement;
  final List<Transaction> debitTransactions;
  final List<Transaction> creditTransactions;
  final double totalDebitAmount;
  final double totalCreditAmount;
  final double totalUpiTransationAmount;
  final List<Transaction> upiTransactions;
  final List<Transaction> otherTransactions;
  final double totalOtherTransationAmount;
  final List<Transaction> salaryTransation;
  final double totalSalaryTransationAmount;
  final List<Transaction> bharatpeTransation;
  final double totalBharatpeTransationAmount;
  final List<Transaction> electricityTransation;
  final double totalElectricityTransationAmount;
  final List<Transaction> rentTransation;
  final double totalRentTransationAmount;
  final List<Transaction> peterolTransation;
  final double totalPeterolTransationAmount;
  final List<Transaction> savingsTransation;
  final double totalSavingsTransationAmount;
  final List<Transaction> policyTransation;
  final double totalPolicyTransationAmount;

  FeatchDetailsSuccessState({
    required this.statement,
    required this.debitTransactions,
    required this.creditTransactions,
    required this.totalDebitAmount,
    required this.totalCreditAmount,
    required this.totalUpiTransationAmount,
    required this.upiTransactions,
    required this.otherTransactions,
    required this.totalOtherTransationAmount,
    required this.salaryTransation,
    required this.totalSalaryTransationAmount,
    required this.bharatpeTransation,
    required this.totalBharatpeTransationAmount,
    required this.electricityTransation,
    required this.totalElectricityTransationAmount,
    required this.rentTransation,
    required this.totalRentTransationAmount,
    required this.peterolTransation,
    required this.totalPeterolTransationAmount,
    required this.savingsTransation,
    required this.totalSavingsTransationAmount,
    required this.policyTransation,
    required this.totalPolicyTransationAmount,
  });
}

final class FeatchDetailsErrorState extends FeatchDetailsState {}

final class FeatchDetailsWithDate extends FeatchDetailsState {
  final List<Transaction> listofTransactionswithDate;

  FeatchDetailsWithDate({required this.listofTransactionswithDate});
}

final class FeatchAnalyticsState extends FeatchDetailsState {}
