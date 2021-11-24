part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState([List props = const []]) : super();
}

class TaskInitial extends TaskState {
  @override
  String toString() {
    return 'TaskInit';
  }

  @override
  List<Object?> get props => [];
}

class TaskDaySelectedLoaded extends TaskState {
  final List<Task> taskSelectedDay;

  const TaskDaySelectedLoaded({required this.taskSelectedDay});

  @override
  List<Object?> get props => [taskSelectedDay];
}
