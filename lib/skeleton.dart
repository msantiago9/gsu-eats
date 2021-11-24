import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsu_eats/screens/homepage.dart';
import 'package:gsu_eats/screens/login.dart';
import 'package:gsu_eats/tools/authhandler.dart';
import 'package:provider/provider.dart';

import 'screens/search.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //These providers are to be used for Firebase authentication
      providers: [
        //This one creates a firebase auth instance and passes it
        //to auth service constructor.
        Provider<AuthService>(
          create: (ignoreThisVariable) => AuthService(FirebaseAuth.instance),
        ),
        //This one creates a stream provider that listens to an authentication
        //state changes--in other words, when a user logs in or logs out.
        StreamProvider(
          create: (alsoIgnoreThis) =>
              alsoIgnoreThis.read<AuthService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: const MaterialApp(
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    //If the user is logged in
    // ignore: unnecessary_null_comparison
    if (firebaseUser != null) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Show Snackbar',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Search(),
                  ),
                );
              },
            ),
          ],
          backgroundColor: Colors.green,
          title: const Text('Hello World'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.cyan.shade400,
                Colors.cyan.shade200,
              ], stops: const [
                0,
                1.0,
              ]),
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              context.read<AuthService>().signOut();
            },
            child: const Icon(
              Icons.exit_to_app, // add custom icons also
            ),
          ),
        ),
        body: const Home(),
      );
    }
    return Scaffold(body: Login());
  }
}