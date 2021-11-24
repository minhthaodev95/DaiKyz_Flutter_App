import 'package:Dailoz/src/models/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class TaskRepository {
  final FirebaseAuth _firebaseAuth;
  TaskRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<List<Task>> getAllTasks(DateTime selectedTime) async {
    String _currentUserUid = _firebaseAuth.currentUser!.uid;
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(_currentUserUid)
    //     .collection('tasks')
    //     .doc()
    //     .set({
    //   "title": "Hoem Coming",
    //   "type": "Procesing",
    //   "description": "Description of the HomeComing"
    // });
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
          .map((element) => Task.fromJson(element.data()))
          .toList();

      return allTasks;
    }

    return [];
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
}
