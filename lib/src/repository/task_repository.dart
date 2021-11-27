import 'package:Dailoz/src/models/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class TaskRepository {
  final FirebaseAuth _firebaseAuth;
  TaskRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  // Get all tasks by Datetime ...
  Future<List<Task>> getAllTasks(DateTime selectedTime) async {
    String _currentUserUid = _firebaseAuth.currentUser!.uid;

    QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(_currentUserUid)
        .collection('tasks')
        .orderBy('dateStart', descending: false)
        .get();

    // Check day of task
    if (response.size > 0) {
      List<Task> allTasks = response.docs
          .where((element) =>
              element['dateTask'] ==
              DateFormat('dd-MM-yyyy').format(selectedTime))
          .map((element) {
        return Task.fromJson(element.data(), element.id);
      }).toList();

      return allTasks;
    }

    return [];
  }

  // get  tasks by process
  Future<List<Task>> getAllTasksByProcess(
      DateTime selectedTime, String process) async {
    String _currentUserUid = _firebaseAuth.currentUser!.uid;

    QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(_currentUserUid)
        .collection('tasks')
        .where('process', isEqualTo: process)
        .orderBy('dateStart', descending: false)
        .get();

    // Check day of task

    if (response.size > 0) {
      List<Task> allTasks = response.docs
          .where((element) =>
              element['dateTask'] ==
              DateFormat('dd-MM-yyyy').format(selectedTime))
          .map((element) {
        return Task.fromJson(element.data(), element.id);
      }).toList();

      return allTasks;
    }

    return [];
  }

  Future<List<Task>> getAllTasksByBoard(String boardId) async {
    String _currentUserUid = _firebaseAuth.currentUser!.uid;

    QuerySnapshot<Map<String, dynamic>> response =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_currentUserUid)
            .collection('tasks')
            // .where('typeId', isEqualTo: 'a')
            .orderBy('dateStart', descending: false)
            .get();

    // Check day of task

    if (response.size > 0) {
      List<Task> allTaskByBoard = response.docs
          .where((element) => element['typeId'] == boardId)
          .map((element) {
        return Task.fromJson(element.data(), element.id);
      }).toList();

      return allTaskByBoard;
    }

    return [];
  }

  // Get number of task by process
  Future<int> numberTaskByProcess(String process) async {
    String _currentUserUid = _firebaseAuth.currentUser!.uid;

    QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(_currentUserUid)
        .collection('tasks')
        .where('process', isEqualTo: process)
        .get();
    int totalTask = response.docs.length;
    return totalTask;
  }

  //add NewTask to Firebase

  Future<void> addTask(Task newTask) {
    Map<String, dynamic> task = newTask.toMap();
    String _currentUserUid = _firebaseAuth.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUserUid)
        .collection('tasks')
        .doc()
        .set(task);
  }

  Future<void> deleteTask(String id) {
    String _currentUserUid = _firebaseAuth.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUserUid)
        .collection('tasks')
        .doc(id)
        .delete();
  }

  Future<void> disableTask(String id) {
    String _currentUserUid = _firebaseAuth.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUserUid)
        .collection('tasks')
        .doc(id)
        .update({"process": "pending"});
  }

  Future<void> restoreTask(String id) {
    String _currentUserUid = _firebaseAuth.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUserUid)
        .collection('tasks')
        .doc(id)
        .update({"process": "ongoing"});
  }

  Future<void> completedTask(String id) {
    String _currentUserUid = _firebaseAuth.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUserUid)
        .collection('tasks')
        .doc(id)
        .update({"process": "completed"});
  }

  Future<void> enableTask(String id) {
    String _currentUserUid = _firebaseAuth.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUserUid)
        .collection('tasks')
        .doc(id)
        .update({"process": "ongoing"});
  }
}
