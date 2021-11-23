/// @ Author: Minh Thao Nguyen
/// @ Create Time: 2021-11-19 12:15:42
/// @ Modified by: Minh Thao Nguyen
/// @ Modified time: 2021-11-20 03:21:53
/// @ Description:

import 'dart:async';
import 'package:Dailoz/blocs/login_bloc/bloc/login_event.dart';
import 'package:Dailoz/blocs/login_bloc/bloc/login_state.dart';
import 'package:Dailoz/repository/user_repository.dart';
import 'package:Dailoz/validator/validator.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;

  LoginBloc({required this.userRepository}) : super(LoginState.empty());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          email: event.email, password: event.password);
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validator.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validator.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await userRepository.signInWithGoogle();

      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState(
      {required String email, required String password}) async* {
    yield LoginState.loading();
    try {
      await userRepository.signInWithEmailAndPassword(email, password);

      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
