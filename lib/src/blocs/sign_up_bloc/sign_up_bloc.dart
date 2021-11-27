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

  RegisterBloc({required this.userRepository}) : super(RegisterState.empty()) {
    on<EmailChanged>(_mapEmailChangedToState);
    on<PasswordChanged>(_mapPasswordChangedToState);
    on<LoginWithGooglePressed>(_mapLoginWithGooglePressedToState);
    on<SignUpWithCredentialsPressed>(_mapSignUpWithCredentialsPressedToState);
  }

  // @override
  // Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
  //   if (event is EmailChanged) {
  //     yield* _mapEmailChangedToState(event.email);
  //   } else if (event is PasswordChanged) {
  //     yield* _mapPasswordChangedToState(event.password);
  //   } else if (event is LoginWithGooglePressed) {
  //     yield* _mapLoginWithGooglePressedToState();
  //   } else if (event is SignUpWithCredentialsPressed) {
  //     yield* _mapSignUpWithCredentialsPressedToState(
  //         userName: event.userName,
  //         email: event.email,
  //         password: event.password);
  //   }
  // }

  void _mapEmailChangedToState(
      EmailChanged event, Emitter<RegisterState> emit) async {
    emit(state.update(isEmailValid: Validator.isValidEmail(event.email)));
  }

  void _mapPasswordChangedToState(
      PasswordChanged event, Emitter<RegisterState> emit) async {
    emit(state.update(
        isPasswordValid: Validator.isValidPassword(event.password)));
  }

  void _mapLoginWithGooglePressedToState(
      LoginWithGooglePressed event, Emitter<RegisterState> emit) async {
    try {
      await userRepository.signInWithGoogle();

      emit(RegisterState.success());
    } catch (_) {
      emit(RegisterState.failure());
    }
  }

  void _mapSignUpWithCredentialsPressedToState(
      SignUpWithCredentialsPressed event, Emitter<RegisterState> emit) async {
    emit(RegisterState.loading());
    try {
      await userRepository.signUp(event.userName, event.email, event.password);
      emit(RegisterState.success());
    } catch (_) {
      emit(RegisterState.failure());
    }
  }
}
