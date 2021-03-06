part of 'sign_up_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent([List props = const []]) : super();
}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({required this.email}) : super([email]);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged({required this.password}) : super([password]);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginWithGooglePressed extends RegisterEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class SignUpWithCredentialsPressed extends RegisterEvent {
  final String userName;
  final String email;
  final String password;

  SignUpWithCredentialsPressed(
      {required this.email, required this.password, required this.userName})
      : super([email, password, userName]);

  @override
  List<Object?> get props => throw UnimplementedError();
}
