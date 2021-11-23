/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-18 16:30:05
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-20 15:48:44
 ///  Description:
 */

part of 'auth_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState([List props = const []]);
}

//
class Uninitialized extends AuthenticationState {
  @override
  String toString() {
    return 'Uninitialized';
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}

class Authenticated extends AuthenticationState {
  final User currentUser;

  Authenticated({required this.currentUser}) : super([currentUser]);
  @override
  String toString() {
    return 'Authenticated';
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() {
    return 'Unauthenticated';
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}
