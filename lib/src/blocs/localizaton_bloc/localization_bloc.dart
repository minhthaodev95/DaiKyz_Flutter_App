import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(EnglishState()) {
    on<ChangeToEnglish>(_changeToEnglishState);
    on<ChangeToVietnamese>(_changeToVietnameseState);
  }

  void _changeToEnglishState(
      ChangeToEnglish event, Emitter<LocalizationState> emit) {
    emit(EnglishState());
  }

  void _changeToVietnameseState(
      ChangeToVietnamese event, Emitter<LocalizationState> emit) {
    emit(VietnameseState());
  }
}
