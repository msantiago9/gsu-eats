import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsu_eats/models/user.dart';
import 'package:gsu_eats/tools/dbhandler.dart';

class AuthService {
  final FirebaseAuth _authHandler;

  //Constructor, just creates the FirebaseAuth class.
  AuthService(this._authHandler);

  Stream<User?> get authStateChanges => _authHandler.authStateChanges();

  //Signs the user in with email and password.
  Future<UserData> signIn(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      UserCredential _user = await _authHandler.signInWithEmailAndPassword(
          email: email, password: password);

      String uuid = _user.user!.uid;
      return DBServ().getUserByUUID(uuid);
    } on FirebaseAuthException catch (error) {
      String msg = 'SignIn failed... $error';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
        ),
      );
      return UserData(name: '', ratings: {}, uuid: '');
    }
  }

  //Attempts to create an account for the user on Firestore.
  Future<bool> signUp({required String email, required String password}) async {
    try {
      await _authHandler.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (error) {
      // ignore: avoid_print
      print("error: $error.message");
      return false;
    }
  }

  Future<void> signOut() async {
    await _authHandler.signOut();
  }
}
