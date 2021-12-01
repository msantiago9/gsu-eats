import 'package:gsu_eats/tools/dbhandler.dart';

class Restaurant {
  final String uuid;
  final String name;
  List<int> ratings;
  Restaurant({required this.uuid, required this.name, required this.ratings});

  void addRating(int rating) {
    ratings.add(rating);
    DBServ().updateRestaurant(this);
  }
}
