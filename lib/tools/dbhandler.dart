import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:gsu_eats/models/restaurant.dart';
import 'package:gsu_eats/models/user.dart';

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

  Future<Restaurant> getRestaurant(String name) async {
    List<Restaurant> collection = await getRestaurants();
    for (Restaurant current in collection) {
      if (current.name == name) {
        return current;
      }
    }
    return Restaurant(uuid: '', name: '', ratings: []);
  }

  Future<Restaurant> getRestaurantByUUID(String uuid) async {
    List<Restaurant> collection = await getRestaurants();
    for (Restaurant current in collection) {
      if (current.uuid == uuid) {
        return current;
      }
    }
    return Restaurant(uuid: '', name: '', ratings: []);
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
      String uuid = element.id;
      String name = element.get('name');
      List<int> ratings = element.get('ratings').cast<int>();
      mylist.add(Restaurant(uuid: uuid, name: name, ratings: ratings));
    }
    return mylist;
  }

  Future addUser(String name, context) async {
    String uuid = const Uuid().v4();
    //By default, the user is set to rate Subway at 1 star.
    Map<String, int> ratings = <String, int>{'6JBZPvJLAbhR6ucjv0Up': 1};

    try {
      if (name == '') {
        throw Exception('No name');
      }
      userDB.doc(uuid).set({'name': name, 'ratings': ratings});
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
      Map<String, int> ratings = element.get('ratings');
      mylist.add(UserData(uuid: uuid, name: name, ratings: ratings));
    }
    return mylist;
  }

  void updateRestaurant(Restaurant restaurant) async {
    try {
      if (restaurant.name == '') {
        throw Exception('No name');
      }
      if (!(await isRestaurant(restaurant.name))) {
        throw Exception(
            'No such restaurant with name $restaurant.name exists.');
      }
      restaurantDB
          .doc(restaurant.uuid)
          .set({'name': restaurant.name, 'ratings': restaurant.ratings});
    } catch (err) {
      // ignore: avoid_print
      print(err.toString());
    }
  }

  void updateUser(String uid) async {
    try {
      if (uid == '') {
        throw Exception('Not a valid uid.');
      }
      if (!(await isUserByUUID(uid))) {
        throw Exception('No such user with uid $uid exists.');
      }
      UserData user = await getUserByUUID(uid);
      userDB.doc(user.uuid).set({'name': user.name, 'ratings': user.ratings});
    } catch (err) {
      // ignore: avoid_print
      print(err.toString());
    }
  }
}
