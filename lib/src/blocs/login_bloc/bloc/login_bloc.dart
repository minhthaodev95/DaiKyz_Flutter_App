/// @ Author: Minh Thao Nguyen
/// @ Create Time: 2021-11-19 12:15:42
/// @ Modified by: Minh Thao Nguyen
/// @ Modified time: 2021-11-20 03:21:53
/// @ Description:

import 'package:Dailoz/src/blocs/login_bloc/bloc/login_event.dart';
import 'package:Dailoz/src/blocs/login_bloc/bloc/login_state.dart';
import 'package:Dailoz/src/repository/user_repository.dart';
import 'package:Dailoz/src/validator/validator.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;

  LoginBloc({required this.userRepository}) : super(LoginState.empty()) {
    on<EmailChanged>(_mapEmailChangedToState);
    on<PasswordChanged>(_mapPasswordChangedToState);
    on<LoginWithGooglePressed>(_mapLoginWithGooglePressedToState);
    on<LoginWithCredentialsPressed>(_mapLoginWithCredentialsPressedToState);
  }

  void _mapEmailChangedToState(
      EmailChanged event, Emitter<LoginState> emit) async {
    emit(state.update(isEmailValid: Validator.isValidEmail(event.email)));
  }

  void _mapPasswordChangedToState(
      PasswordChanged event, Emitter<LoginState> emit) async {
    emit(state.update(
        isPasswordValid: Validator.isValidPassword(event.password)));
  }

  void _mapLoginWithGooglePressedToState(
      LoginWithGooglePressed event, Emitter<LoginState> emit) async {
    try {
      await userRepository.signInWithGoogle();

      emit(LoginState.success());
    } catch (_) {
      emit(LoginState.failure());
    }
  }

  void _mapLoginWithCredentialsPressedToState(
      LoginWithCredentialsPressed event, Emitter<LoginState> emit) async {
    emit(LoginState.loading());
    try {
      await userRepository.signInWithEmailAndPassword(
          event.email, event.password);

      emit(LoginState.success());
    } catch (_) {
      emit(LoginState.failure());
    }
  }
}
