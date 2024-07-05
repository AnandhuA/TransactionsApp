part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoadingState extends AuthenticationState {}

final class AuthenticationSuccessState extends AuthenticationState {}

final class AuthenticationErrorState extends AuthenticationState {
  final String error;

  AuthenticationErrorState({required this.error});
}
