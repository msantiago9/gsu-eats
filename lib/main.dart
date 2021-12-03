import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gsu_eats/skeleton.dart';

//Invokes running the materialapp widget from skeleton.dart
//Basically, it runs our app.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
//hello