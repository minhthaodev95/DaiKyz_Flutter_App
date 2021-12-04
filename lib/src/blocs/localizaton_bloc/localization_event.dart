part of 'localization_bloc.dart';

abstract class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}

class ChangeToEnglish extends LocalizationEvent {}

class ChangeToVietnamese extends LocalizationEvent {}
