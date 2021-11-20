/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-18 14:58:53
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-20 03:24:03
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

    final String? userName = googleUser!.displayName;
    final String? userEmail = googleUser.email;
    final String? userUrlPhoto = googleUser.photoUrl;
    // infomations get from google account
    print(userName);
    print(userEmail);
    print(userUrlPhoto);
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // check user login with google account first time
    final bool firstTime = user.additionalUserInfo!.isNewUser;
    print(firstTime);
    // Once signed in, return the UserCredential
    return user;
  }

  // Singin With Email And Password

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
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

  Future<String?> getUser() async {
    return _firebaseAuth.currentUser!.email;
  }
}
