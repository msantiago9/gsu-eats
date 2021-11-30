import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:gsu_eats/models/restaurant.dart';

class DBServ {
  //This class will contain a reference to the Firestore collection containing user data.

  final CollectionReference userDB =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference restaurantDB =
      FirebaseFirestore.instance.collection('restaurants');

  // Since we no user first name and last name implemented yet, this function cannot be set.
  // Future update(String fname, String lname, String type) async {
  //   return await userDB
  //       .doc(uid)
  //       .set({'fname': fname, 'lname': lname, 'type': type});
  // }

  Stream<QuerySnapshot> get userdata {
    return userDB.snapshots();
  }

  bool addRestaurant(Restaurant restaurant, BuildContext context) {
    String restaurantID = const Uuid().v4();

    try {
      if (restaurant.name == '') {
        throw Exception('No name');
      }
      restaurantDB
          .doc(restaurantID)
          .set({'name': restaurant.name, 'ratings': restaurant.ratings});
    } catch (err) {
      String msg = 'Adding Restaurant failed... $err';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
        ),
      );
      return false;
    }
    return true;
  }

  Future<List<Restaurant>> getRestaurants() async {
    return await restaurantDB.snapshots().map(restaurantListFromSnapshot).first;
  }

  //message list from snapshot
  List<Restaurant> restaurantListFromSnapshot(QuerySnapshot snap) {
    List<Restaurant> mylist = [];
    for (var element in snap.docs) {
      String name = element.get('name');
      List<int> ratings = element.get('ratings').cast<int>();
      mylist.add(Restaurant(name: name, ratings: ratings));
    }
    return mylist;
  }

  Future<bool> hasRestaurant(String name) async {
    List<Restaurant> collection = await getRestaurants();
    for (Restaurant current in collection) {
      if (current.name == name) {
        return true;
      }
    }
    return false;
  }

  Future<Restaurant> getRestaurant(String name) async {
    List<Restaurant> collection = await getRestaurants();
    for (Restaurant current in collection) {
      if (current.name == name) {
        return current;
      }
    }
    return Restaurant(name: '', ratings: []);
  }
}
