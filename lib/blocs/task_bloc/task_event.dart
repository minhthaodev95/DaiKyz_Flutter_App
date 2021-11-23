part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent([List props = const []]) : super();
}

class SelectedDayTask extends TaskEvent {
  final DateTime daySelected;
  const SelectedDayTask({required this.daySelected});

  @override
  List<Object?> get props => [daySelected];
}
