/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-19 12:15:42
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-20 03:24:37
 ///  Description:
 */

import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super();
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({required this.email}) : super([email]);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({required this.password}) : super([password]);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginWithGooglePressed extends LoginEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentialsPressed({required this.email, required this.password})
      : super([email, password]);

  @override
  List<Object?> get props => throw UnimplementedError();
}
