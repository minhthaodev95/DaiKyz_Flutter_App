import 'package:Dailoz/models/task_model.dart';
import 'package:Dailoz/repository/task_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<SelectedDayTask>(_selectedDayTask);
  }

  void _selectedDayTask(SelectedDayTask event, Emitter<TaskState> emit) async {
    DateTime _daySelected = event.daySelected;
    List<Task> tasks = await TaskRepository().getAllTasks(_daySelected);
    emit(TaskDaySelectedLoaded(taskSelectedDay: tasks));
  }
}
