part of 'featch_details_bloc.dart';

@immutable
sealed class FeatchDetailsState {}

final class FeatchDetailsInitial extends FeatchDetailsState {}

final class FeatchDetailsLoadingState extends FeatchDetailsState {}

final class FeatchDetailsSuccessState extends FeatchDetailsState {
  final AccountStatement statement;

  FeatchDetailsSuccessState({required this.statement});
}

final class FeatchDetailsErrorState extends FeatchDetailsState {}
