import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transaction_app/network/fire_base_function.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<SignUpEvent>(_signUpEvent);

    on<LoginEvent>(_loginEvent);
  }

  FutureOr<void> _signUpEvent(
    SignUpEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoadingState());
    String responce = await AuthenticationRepo.signUp(
      email: event.email,
      password: event.password,
    );
    if (responce == "Success") {
      emit(AuthenticationSuccessState());
    } else {
      emit(AuthenticationErrorState(error: responce));
    }
  }
}

FutureOr<void> _loginEvent(
  LoginEvent event,
  Emitter<AuthenticationState> emit,
) async {
  emit(AuthenticationLoadingState());
  String responce = await AuthenticationRepo.logIn(
    email: event.email,
    password: event.password,
  );
  if (responce == "Success") {
    emit(AuthenticationSuccessState());
  } else {
    emit(AuthenticationErrorState(error: responce));
  }
}
