import 'package:flutter/material.dart';
import 'package:gsu_eats/screens/popular.dart';
import 'package:gsu_eats/screens/recommended.dart';
import 'package:gsu_eats/screens/admin.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 15),
            child: const Text(
              "Hello!",
              style: TextStyle(
                fontFamily: 'Kurale',
                fontSize: 20,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Popular(),
                  ),
                );
              },
              child: const Text("Most Popular"),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Recommended(),
                  ),
                );
              },
              child: const Text("Recommended For Me"),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Admin(),
                  ),
                );
              },
              child: const Text("Admin"),
            ),
          ),
        ],
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
