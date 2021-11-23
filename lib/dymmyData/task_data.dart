/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-22 16:29:31
 ///  Description:
 */

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
      dateTask: "22-November-2021",
      typeId: '1',
      tags: ['home', 'computer'],
      process: 'pending'),
  Task(
      id: '2',
      title: 'Task 2',
      description: 'Task 2 description',
      dateStart: DateTime.parse("2021-11-06 20:18:05"),
      dateEnd: DateTime.parse("2021-11-06 20:38:05"),
      dateTask: "22-November-2021",
      typeId: '2',
      tags: ['work', 'computer', 'Urgent'],
      process: 'canceled'),
  Task(
      id: '3',
      title: 'Task 3',
      description: 'Task 3 description',
      dateTask: "22-November-2021",
      dateStart: DateTime.now(),
      dateEnd: DateTime.now().add(
        const Duration(minutes: 40),
      ),
      typeId: '3',
      tags: ['work', 'clothes'],
      process: 'ongoing'),
  Task(
      id: '4',
      title: 'Task 4',
      description: 'Task 4 description',
      dateTask: "22-November-2021",
      dateStart: DateTime.now(),
      dateEnd: DateTime.now().add(
        const Duration(minutes: 20),
      ),
      typeId: '4',
      tags: ['work', 'ipad'],
      process: 'completed'),
];
