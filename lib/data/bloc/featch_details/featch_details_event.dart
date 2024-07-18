part of 'featch_details_bloc.dart';

@immutable
sealed class FeatchDetailsEvent {}

final class FeatchAllDetailsEvent extends FeatchDetailsEvent {}

final class FeatchIteamWithDate extends FeatchAllDetailsEvent {
  final DateTime date;

  FeatchIteamWithDate({
    required this.date,
  });
}

final class FeatchAnalyticsEvent extends FeatchDetailsEvent {
  final String year;
  final String month;

  FeatchAnalyticsEvent({required this.year, required this.month});
}


final class FeateHomeDetailsWithDate extends FeatchDetailsEvent {
  final DateTime date;

  FeateHomeDetailsWithDate({
    required this.date,
  });
}