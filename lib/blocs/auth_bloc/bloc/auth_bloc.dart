/*
 /// @ Author: Minh Thao Nguyen
 /// @ Create Time: 2021-11-18 16:30:05
 /// @ Modified by: Minh Thao Nguyen
 /// @ Modified time: 2021-11-20 03:23:03
 /// @ Description:
 */

import 'package:Dailoz/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository}) : super(Uninitialized()) {
    on<AppStarted>(_mapAppStartedToState);
    on<LoggedIn>(_mapLoggedInToState);
    on<LoggedOut>(_mapLoggedOutToState);
  }

  void _mapAppStartedToState(
      AppStarted event, Emitter<AuthenticationState> emit) async {
    try {
      final isSignIn = await userRepository.isSignIn();
      if (isSignIn) {
        final currentUser = await userRepository.getUser();
        emit(Authenticated(currentUser: currentUser!));
      } else {
        emit(Uninitialized());
      }
    } catch (_) {}
  }

  void _mapLoggedInToState(
      LoggedIn event, Emitter<AuthenticationState> emit) async {
    final currentUser = await userRepository.getUser();
    emit(Authenticated(currentUser: currentUser!));
  }

  void _mapLoggedOutToState(
      LoggedOut event, Emitter<AuthenticationState> emit) async {
    emit(Unauthenticated());

    userRepository.signOut();
  }
}
