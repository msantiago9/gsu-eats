import 'package:flutter/material.dart';
import 'package:gsu_eats/tools/dbhandler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gsu_eats/models/restaurant.dart';
import 'package:uuid/uuid.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final dbserve = DBServ();
  final name = TextEditingController();
  List<int> ratings = [3, 3, 3];
  List<Widget> restaurants = [];
  bool hasSearched = false;

  void _updateRestaurantsList(Restaurant restaurant) {
    setState(() {
      restaurants = [
        ...restaurants,
        Container(
          margin: const EdgeInsets.all(5),
          child: Row(
            children: [
              Text(restaurant.name),
              Text(restaurant.ratings.toString())
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
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin"),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: const Text(
                  "Enter a new restaurant",
                  style: TextStyle(
                    fontFamily: 'Kurale',
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    labelText: "restaurant name",
                  ),
                  autocorrect: false,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    ratings[0] = rating.round();
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    ratings[1] = rating.round();
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    ratings[2] = rating.round();
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: ElevatedButton(
                  onPressed: () {
                    Restaurant toDatabase = Restaurant(
                        uuid: const Uuid().v4(),
                        name: name.text,
                        ratings: ratings);
                    bool success = dbserve.addRestaurant(toDatabase, context);
                    if (success && hasSearched) {
                      _updateRestaurantsList(toDatabase);
                    }
                  },
                  child: const Text(
                    "Add Restaurant",
                  ),
                ),
              ),

              //Section 2

              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: const Text(
                  "Get All Restaurants in Firestore",
                  style: TextStyle(
                    fontFamily: 'Kurale',
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: ElevatedButton(
                  onPressed: () async {
                    if (!hasSearched) {
                      List<Restaurant> collection =
                          await dbserve.getRestaurants();
                      for (var restaurant in collection) {
                        _updateRestaurantsList(restaurant);
                      }
                      setState(() {
                        hasSearched = true;
                      });
                    }
                  },
                  child: const Text(
                    "Search",
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: ListView.builder(
                  itemCount: restaurants.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return restaurants[index];
                  },
                ),
              ),
            ],
          ),
        ),
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
      ),
    );
  }
}
