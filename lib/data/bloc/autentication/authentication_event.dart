part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

final class SignUpEvent extends AuthenticationEvent {
  final String name;
  final String email;
  final String password;

  SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

final class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password,
  });
}
