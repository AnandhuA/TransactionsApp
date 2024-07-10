part of 'bottam_navigation_bloc.dart';

@immutable
sealed class BottamNavigationEvent {}


class TabChanged extends BottamNavigationEvent {
  final int index;

  TabChanged(this.index);
}
