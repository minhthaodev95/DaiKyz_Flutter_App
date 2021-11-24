import 'package:Dailoz/src/repository/user_repository.dart';
import 'package:Dailoz/src/validator/validator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

/*
 * @Author: Minh Thao Nguyen 
 * @Date: 2021-07-21 06:35:14 
 * @Last Modified by: Minh Thao Nguyen
 * @Last Modified time: 2021-07-21 08:51:40
 */

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository userRepository;

  RegisterBloc({required this.userRepository}) : super(RegisterState.empty());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is SignUpWithCredentialsPressed) {
      yield* _mapSignUpWithCredentialsPressedToState(
          userName: event.userName,
          email: event.email,
          password: event.password);
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validator.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validator.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapLoginWithGooglePressedToState() async* {
    try {
      await userRepository.signInWithGoogle();
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }

  Stream<RegisterState> _mapSignUpWithCredentialsPressedToState(
      {required String userName,
      required String email,
      required String password}) async* {
    yield RegisterState.loading();
    try {
      await userRepository.signUp(userName, email, password);
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
