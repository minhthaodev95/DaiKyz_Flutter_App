import 'package:Dailoz/src/models/type_model.dart';
import 'package:Dailoz/src/repository/get_boards.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'board_event.dart';
part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc() : super(BoardInitial()) {
    on<LoadBoard>(_initBoards);
  }

  void _initBoards(BoardEvent event, Emitter<BoardState> emit) async {
    // await Boards().updateTotalTasks();
    List<TaskType> allBoards = await Boards().getAllBoards();
    emit(BoardLoaded(allBoards: allBoards));
  }
}
