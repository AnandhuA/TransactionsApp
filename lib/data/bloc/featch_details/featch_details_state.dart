part of 'featch_details_bloc.dart';

@immutable
sealed class FeatchDetailsState {}

final class FeatchDetailsInitial extends FeatchDetailsState {}

final class FeatchDetailsLoadingState extends FeatchDetailsState {}

final class FeatchDetailsSuccessState extends FeatchDetailsState {
  final AccountStatement statement;
  final List<Transaction> debitTransactions;
  final List<Transaction> creditTransactions;

  FeatchDetailsSuccessState({
    required this.debitTransactions,
    required this.creditTransactions,
    required this.statement,
  });
}

final class FeatchDetailsErrorState extends FeatchDetailsState {}
