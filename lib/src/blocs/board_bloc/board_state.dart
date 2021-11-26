part of 'board_bloc.dart';

abstract class BoardState extends Equatable {
  const BoardState([List props = const []]) : super();
}

class BoardInitial extends BoardState {
  @override
  List<Object?> get props => [];
}

class BoardLoaded extends BoardState {
  final List<TaskType> allBoards;

  const BoardLoaded({required this.allBoards});

  @override
  List<Object?> get props => [allBoards];
}
