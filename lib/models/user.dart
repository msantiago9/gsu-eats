import 'restaurant.dart';
import 'package:gsu_eats/tools/dbhandler.dart';

class UserData {
  String uuid;
  String name;
  //Key String is the uuid of a restaurant.
  Map<String, int> ratings;

  UserData({required this.uuid, required this.name, required this.ratings});

  Future<List<Restaurant>> get reviewedRestaurants async {
    final dbserve = DBServ();
    List<Restaurant> restaurants = [];
    ratings.forEach((uuid, rating) async {
      Restaurant current = await dbserve.getRestaurantByUUID(uuid);
      restaurants.add(current);
    });
    return restaurants;
  }

  void addRating(String uuid, int rating) {
    ratings[uuid] = rating;
    DBServ().updateUser(this);
  }

  bool rated(String uuid) {
    return ratings.containsKey(uuid);
  }

  int getRating(String uuid) {
    return ratings[uuid]!;
  }
}
