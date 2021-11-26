import 'package:Dailoz/src/models/type_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Boards {
  final FirebaseAuth _firebaseAuth;
  Boards({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<List<TaskType>> getAllBoards() async {
    String _currentUserUid = _firebaseAuth.currentUser!.uid;

    QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(_currentUserUid)
        .collection('boards')
        .get();

    List<TaskType> allBoards = response.docs.map((element) {
      return TaskType.fromJson(element.data());
    }).toList();

    return allBoards;
  }
}
