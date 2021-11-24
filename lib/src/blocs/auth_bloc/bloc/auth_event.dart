/*
/// @ Author: Minh Thao Nguyen
/// @ Create Time: 2021-11-18 16:30:05
/// @ Modified by: Minh Thao Nguyen
/// @ Modified time: 2021-11-20 03:20:49
/// @ Description:
*/
part of 'auth_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {}

class AppStarted extends AuthenticationEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoggedIn extends AuthenticationEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoggedOut extends AuthenticationEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
