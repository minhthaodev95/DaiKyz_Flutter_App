/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-19 12:15:42
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-21 18:53:41
 ///  Description:
 */

import 'package:meta/meta.dart';

@immutable
class LoginState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  bool get isFormValid => isEmailValid && isPasswordValid;

  const LoginState(
      {required this.isEmailValid,
      required this.isFailure,
      required this.isPasswordValid,
      required this.isSubmitting,
      required this.isSuccess});

  factory LoginState.empty() {
    return const LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isFailure: false,
        isSubmitting: false,
        isSuccess: false);
  }
  factory LoginState.loading() {
    return const LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isFailure: false,
        isSubmitting: true,
        isSuccess: false);
  }
  factory LoginState.success() {
    return const LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isFailure: false,
        isSubmitting: false,
        isSuccess: true);
  }
  factory LoginState.failure() {
    return const LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isFailure: true,
        isSubmitting: false,
        isSuccess: false);
  }

  LoginState copyWith({
    required bool isEmailValid,
    required bool isPasswordValid,
    required bool isSubmitEnabled,
    required bool isSubmitting,
    required bool isSuccess,
    required bool isFailure,
  }) {
    return LoginState(
        isEmailValid: isEmailValid,
        isFailure: isFailure,
        isPasswordValid: isPasswordValid,
        isSubmitting: isSubmitting,
        isSuccess: isSuccess);
  }

  LoginState update({bool? isEmailValid, bool? isPasswordValid}) {
    return copyWith(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        isSubmitEnabled: false);
  }
}
