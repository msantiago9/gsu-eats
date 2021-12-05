import 'package:gsu_eats/tools/dbhandler.dart';

class Restaurant {
  String uuid;
  String name;
  List<int> ratings;
  Restaurant({required this.uuid, required this.name, required this.ratings});

  void addRating(int rating) {
    print(rating);
    ratings.add(rating);
    DBServ().updateRestaurant(this);
  }

  void removeRating(int rating) async {
    for (int i = 0; i < ratings.length; i++) {
      if (ratings[i] == rating) {
        ratings.removeAt(i);
        break;
      }
    }
    await DBServ().updateRestaurant(this);
  }
}
