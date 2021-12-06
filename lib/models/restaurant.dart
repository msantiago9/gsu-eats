import 'package:gsu_eats/tools/dbhandler.dart';

class Restaurant {
  String uuid;
  String name;
  String img;
  String details;
  List<int> ratings;
  Map<String, String> comments;
  String latitude;
  String longitude;

  Restaurant({
    required this.uuid,
    required this.name,
    required this.ratings,
    required this.comments,
    required this.latitude,
    required this.longitude,
    required this.img,
    required this.details,
  });

  void update() {
    DBServ().updateRestaurant(this);
  }

  void addRating(int rating) {
    ratings.add(rating);
    update();
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

  void setName(String n) {
    name = n;
    update();
  }

  void addComment(String name, String body) {
    comments[name] = body;
    update();
  }

  void setLocation(String lat, String long) {
    latitude = lat;
    longitude = long;
    update();
  }

  void setDetails(String d) {
    details = d;
    update();
  }

  void setImg(String i) {
    img = i;
    update();
  }
}
