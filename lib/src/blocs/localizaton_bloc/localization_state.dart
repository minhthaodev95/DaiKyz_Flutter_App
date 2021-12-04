part of 'localization_bloc.dart';

abstract class LocalizationState extends Equatable {
  const LocalizationState();

  @override
  List<Object> get props => [];
}

class EnglishState extends LocalizationState {}

class VietnameseState extends LocalizationState {}
