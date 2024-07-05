part of 'featch_details_bloc.dart';

@immutable
sealed class FeatchDetailsState {}

final class FeatchDetailsInitial extends FeatchDetailsState {}

final class FeatchDetailsLoadingState extends FeatchDetailsState {}

final class FeatchDetailsSuccessState extends FeatchDetailsState {
  final AccountStatement statement;
  final List<Transaction> debitTransactions;
  final List<Transaction> creditTransactions;
  // final List<PieChartSectionData> pieChartSections;
  final double totalAmount;
  final List<PieChartSectionData> dailyPieChartSections;
  final List<PieChartSectionData> monthlyPieChartSections;
  final List<PieChartSectionData> yearlyPieChartSections;

  FeatchDetailsSuccessState({
    required this.debitTransactions,
    required this.creditTransactions,
    required this.statement,
    // required this.pieChartSections,
    required this.totalAmount,
    required this.dailyPieChartSections,
    required this.monthlyPieChartSections,
    required this.yearlyPieChartSections,
  });
}

final class FeatchDetailsErrorState extends FeatchDetailsState {}
