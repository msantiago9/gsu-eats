import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gsu_eats/models/restaurant.dart';
import 'package:gsu_eats/models/user.dart';

class DBServ {
  //This class will contain a reference to the Firestore collection containing user data.

  CollectionReference userDB = FirebaseFirestore.instance.collection('users');

  CollectionReference restaurantDB =
      FirebaseFirestore.instance.collection('places');

  // Since we no user first name and last name implemented yet, this function cannot be set.
  // Future update(String fname, String lname, String type) async {
  //   return await userDB
  //       .doc(uid)
  //       .set({'fname': fname, 'lname': lname, 'type': type});
  // }

  bool addRestaurant(Restaurant restaurant, BuildContext context) {
    String restaurantID = restaurant.uuid;

    try {
      if (restaurant.name == '') {
        throw Exception('No name');
      }
      restaurantDB.doc(restaurantID).set({
        'name': restaurant.name,
        'img': restaurant.img,
        'details': restaurant.details,
        'ratings': restaurant.ratings,
        'comments': restaurant.comments,
        'latitude': restaurant.latitude,
        'longitude': restaurant.longitude,
      });
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

  Future<Restaurant> getRestaurant(String name) async {
    List<Restaurant> collection = await getRestaurants();
    for (Restaurant current in collection) {
      if (current.name == name) {
        return current;
      }
    }
    return Restaurant(
      uuid: '',
      name: '',
      ratings: [],
      comments: {},
      details: '',
      img: '',
      latitude: '',
      longitude: '',
    );
  }

  Future<Restaurant> getRestaurantByUUID(String uuid) async {
    List<Restaurant> collection = await getRestaurants();
    for (Restaurant current in collection) {
      if (current.uuid == uuid) {
        return current;
      }
    }
    return Restaurant(
      uuid: '',
      name: '',
      ratings: [],
      comments: {},
      details: '',
      img: '',
      latitude: '',
      longitude: '',
    );
  }

  Future<List<Restaurant>> getRestaurants() async {
    return await restaurantDB
        .snapshots()
        .map(_restaurantListFromSnapshot)
        .first;
  }

  Future<bool> isRestaurant(String name) async {
    List<Restaurant> collection = await getRestaurants();
    for (Restaurant current in collection) {
      if (current.name == name) {
        return true;
      }
    }
    return false;
  }

  Future<bool> isRestaurantByUUID(String uuid) async {
    List<Restaurant> collection = await getRestaurants();
    for (Restaurant current in collection) {
      if (current.uuid == uuid) {
        return true;
      }
    }
    return false;
  }

  List<Restaurant> _restaurantListFromSnapshot(QuerySnapshot snap) {
    List<Restaurant> mylist = [];
    for (var element in snap.docs) {
      // print(element.data());
      try {
        String uuid = element.id;
        String name = element.get('name');
        String details = element.get('details');
        String img = element.get('img');
        String lat = element.get('latitude');
        String long = element.get('longitude');
        List<dynamic> ratings = element.get('ratings');
        Map<String, String> comments =
            Map<String, String>.from(element.get('comments'));
        mylist.add(
          Restaurant(
            uuid: uuid,
            name: name,
            ratings: ratings.map((s) => int.parse(s.toString())).toList(),
            comments: comments,
            details: details,
            img: img,
            latitude: lat,
            longitude: long,
          ),
        );
      } catch (err) {
        String msg = err.toString();
        // ignore: avoid_print
        print("error was thrown... $msg");
        continue;
      }
    }
    return mylist;
  }

  Future addUser(String name, String uid, context) async {
    //By default, the user is set to rate Subway at 1 star.
    Map<String, int> ratings = <String, int>{'LiBCFqJmH3llBPYRk2RF': 1};
    try {
      if (name == '') {
        throw Exception('No name');
      }
      userDB.doc(uid).set({'name': name, 'ratings': ratings});
    } catch (err) {
      String msg = 'Adding User failed... $err';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
        ),
      );
      return false;
    }
    return true;
  }

  Future<UserData> getUserByUUID(String uuid) async {
    List<UserData> collection = await getUsers();
    for (UserData current in collection) {
      if (current.uuid == uuid) {
        return current;
      }
    }
    return UserData(uuid: '', name: '', ratings: <String, int>{});
  }

  Future<List<UserData>> getUsers() async {
    return await userDB.snapshots().map(_userListFromSnapshot).first;
  }

  Future<bool> isUserByUUID(String uuid) async {
    List<UserData> collection = await getUsers();
    for (UserData current in collection) {
      if (current.uuid == uuid) {
        return true;
      }
    }
    return false;
  }

  List<UserData> _userListFromSnapshot(QuerySnapshot snap) {
    List<UserData> mylist = [];
    for (var element in snap.docs) {
      String uuid = element.id;
      String name = element.get('name');
      Map<String, int> ratings = Map<String, int>.from(element.get('ratings'));
      mylist.add(UserData(uuid: uuid, name: name, ratings: ratings));
    }
    return mylist;
  }

  Future updateRestaurant(Restaurant restaurant) async {
    try {
      if (restaurant.name == '') {
        throw Exception('No name');
      }
      if (!(await isRestaurant(restaurant.name))) {
        throw Exception(
            'No such restaurant with name $restaurant.name exists.');
      }
      restaurantDB.doc(restaurant.uuid).set({
        'name': restaurant.name,
        'img': restaurant.img,
        'details': restaurant.details,
        'ratings': restaurant.ratings,
        'comments': restaurant.comments,
        'latitude': restaurant.latitude,
        'longitude': restaurant.longitude,
      });
    } catch (err) {
      // ignore: avoid_print
      print(err.toString());
    }
  }

  void updateUser(UserData current) async {
    try {
      if (current.uuid == '') {
        throw Exception('Not a valid uid.');
      }
      if (!(await isUserByUUID(current.uuid))) {
        throw Exception('No such user with uid $current.uuid exists.');
      }
      userDB
          .doc(current.uuid)
          .set({'name': current.name, 'ratings': current.ratings});
    } catch (err) {
      // ignore: avoid_print
      print(err.toString());
    }
  }
}
