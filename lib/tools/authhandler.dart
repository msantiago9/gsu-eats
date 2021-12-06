import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsu_eats/models/user.dart';
import 'package:gsu_eats/tools/dbhandler.dart';
import 'package:gsu_eats/models/globals.dart' as globals;

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
      Future<UserData> current = DBServ().getUserByUUID(uuid);
      current.then((user) {
        globals.name = user.name;
        globals.uuid = user.uuid;
        globals.ratings = user.ratings;
      });
      return current;
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
  Future<String> signUp(
      {required String email, required String password}) async {
    try {
      UserCredential uc = await _authHandler.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = uc.user!.uid;
      Future<UserData> current = DBServ().getUserByUUID(uid);
      current.then((user) {
        globals.name = user.name;
        globals.uuid = user.uuid;
        globals.ratings = user.ratings;
      });
      return uid;
    } on FirebaseAuthException catch (error) {
      // ignore: avoid_print
      print("error: $error.message");
      return "error";
    }
  }

  Future<void> signOut() async {
    await _authHandler.signOut();
  }
}
