/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-18 14:58:53
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-23 11:26:08
 ///  Description:
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  // sign in with google credential
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // final String uid = _firebaseAuth.currentUser!.uid;
    // check user login with google account first time
    // final bool firstTime = user.additionalUserInfo!.isNewUser;
    //connect to Firebase
    // if (firstTime) {
    //   FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(uid)
    //       .collection('tasks')
    //       .add({'title': 'Task1'});
    // }
    // Once signed in, return the UserCredential
    return user;
  }

  // Singin With Email And Password

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signUp(
      String userName, String email, String password) async {
    UserCredential credential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    _firebaseAuth.currentUser!.updateDisplayName(userName);
    return credential;
  }

  Future<bool> isSignIn() async {
    return _firebaseAuth.currentUser != null;
  }

  Future<List<void>> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      GoogleSignIn().signOut(),
    ]);
  }

  Future<User?> getUser() async {
    return _firebaseAuth.currentUser!;
  }
}
