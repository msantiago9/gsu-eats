import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final TextEditingController query = TextEditingController();
  Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("search"),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                child: TextField(
                  controller: query,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    labelText: "\"Dunkin' Donuts\"",
                    alignLabelWithHint: true,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  //ToDo add search
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Search to be implemented :)'),
                    ),
                  );
                },
                child: const Text("Search"),
              ),
            ],
          ),
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
        ),
      ),
    );
  }
}