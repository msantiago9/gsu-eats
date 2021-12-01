import 'package:flutter/material.dart';
import 'package:gsu_eats/screens/restaurantpage.dart';
import 'package:gsu_eats/tools/dbhandler.dart';
import 'package:gsu_eats/models/restaurant.dart';

class Search extends StatelessWidget {
  final dbserve = DBServ();
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
                onPressed: () async {
                  if (await dbserve.isRestaurant(query.text)) {
                    Restaurant restaurant =
                        await dbserve.getRestaurant(query.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RestaurantPage(restaurant: restaurant),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('No restaurant found.'),
                      ),
                    );
                  }
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
