import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _authHandler;

  //Constructor, just creates the FirebaseAuth class.
  AuthService(this._authHandler);

  Stream<User?> get authStateChanges => _authHandler.authStateChanges();

  //Signs the user in with email and password.
  Future<bool> signIn({required String email, required String password}) async {
    try {
      await _authHandler.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (error) {
      // ignore: avoid_print
      print("error: $error.message");
      return false;
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
