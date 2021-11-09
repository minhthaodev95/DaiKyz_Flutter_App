import 'package:Dailoz/models/task_model.dart';

List<Task> tasks = [
  Task(
      id: '1',
      title: 'Cleaning CLothes',
      description: 'Task description',
      dateStart: DateTime.now(),
      dateEnd: DateTime.now().add(
        const Duration(minutes: 30),
      ),
      typeId: '1',
      tags: ['home', 'computer'],
      process: ProcessType.pending),
  Task(
      id: '2',
      title: 'Task 2',
      description: 'Task 2 description',
      dateStart: DateTime.parse("2021-11-06 20:18:05"),
      dateEnd: DateTime.parse("2021-11-06 20:38:05"),
      typeId: '2',
      tags: ['work', 'computer', 'Urgent'],
      process: ProcessType.canceled),
  Task(
      id: '3',
      title: 'Task 3',
      description: 'Task 3 description',
      dateStart: DateTime.now(),
      dateEnd: DateTime.now().add(
        const Duration(minutes: 40),
      ),
      typeId: '3',
      tags: ['work', 'clothes'],
      process: ProcessType.ongoing),
  Task(
      id: '4',
      title: 'Task 4',
      description: 'Task 4 description',
      dateStart: DateTime.now(),
      dateEnd: DateTime.now().add(
        const Duration(minutes: 20),
      ),
      typeId: '4',
      tags: ['work', 'ipad'],
      process: ProcessType.completed),
];
