// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:Dailoz/src/models/task_model.dart';
import 'package:Dailoz/src/repository/task_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  await Firebase.initializeApp();
  test('Test get all task', () async {
    // Build our app and trigger a frame.
    // Task newTask = Task(
    //     id: '1',
    //     title: 'Cleaning CLothes',
    //     description: 'Task description',
    //     dateTask: DateFormat('dd-MM-yyyy').format(DateTime.now()),
    //     dateStart: DateTime.now(),
    //     dateEnd: DateTime.now().add(
    //       const Duration(minutes: 30),
    //     ),
    //     typeId: '1',
    //     tags: ['home', 'computer'],
    //     process: 'ongoing');

    expect(await TaskRepository().getTaskById('KY3YbhohFmWEDrtXDi3IjbUWW1l2'),
        isInstanceOf<Task>());
  });
}
