import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gsu_eats/models/restaurant.dart';
import 'package:gsu_eats/models/user.dart';
import 'package:gsu_eats/models/globals.dart' as globals;
import 'package:gsu_eats/screens/maps.dart';

class RestaurantPage extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurantPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  _RestaurantState createState() => _RestaurantState();
}

class _RestaurantState extends State<RestaurantPage> {
  TextEditingController comment = TextEditingController();
  int currentRating = 0;
  Restaurant restaurant = Restaurant(
    uuid: '',
    name: '',
    ratings: [],
    comments: {},
    details: '',
    img: '',
    latitude: '',
    longitude: '',
  );

  @override
  void initState() {
    super.initState();
    initRating(UserData(
        name: globals.name, uuid: globals.uuid, ratings: globals.ratings));
    initRestaurant(
      Restaurant(
        name: widget.restaurant.name,
        uuid: widget.restaurant.uuid,
        ratings: widget.restaurant.ratings,
        comments: widget.restaurant.comments,
        details: widget.restaurant.details,
        img: widget.restaurant.img,
        latitude: widget.restaurant.latitude,
        longitude: widget.restaurant.longitude,
      ),
    );
  }

  void initRating(UserData user) {
    if (user.rated(widget.restaurant.uuid)) {
      setState(() {
        currentRating = user.getRating(widget.restaurant.uuid);
      });
    } else {
      setState(() {
        currentRating = 0;
      });
    }
  }

  void initRestaurant(Restaurant r) {
    setState(() {
      restaurant = r;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Text(
                  '- ' + restaurant.name + ' -',
                  style: const TextStyle(
                    fontFamily: 'Kurale',
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                //ToDO: replace asset with widget.restaurant.image
                //Which means restaurant classs needs a final String image
                child: Image.network(
                  restaurant.img,
                  height: 150,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Text(
                  restaurant.details,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: RatingBar.builder(
                  initialRating: (restaurant.ratings
                          .reduce((value, element) => value + element) /
                      restaurant.ratings.length),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  ignoreGestures: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapsPage(restaurant: restaurant),
                      ),
                    );
                  },
                  child: const Text("Location"),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 45, 0, 5),
                child: const Text(
                  "Leave your rating",
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: RatingBar.builder(
                  initialRating: currentRating.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 30.0,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) async {
                    setState(() {
                      currentRating = rating.round();
                    });
                    UserData user = UserData(
                        name: globals.name,
                        uuid: globals.uuid,
                        ratings: globals.ratings);

                    //If the user has not rated the restaurant before
                    if (!user.rated(restaurant.uuid)) {
                      //Add the rating to the user's list of ratings (on firestore)
                      user.addRating(
                        restaurant.uuid,
                        currentRating,
                      );

                      //Do the same for the current user
                      globals.ratings = user.ratings;

                      //Add the rating to the restaurant's list of ratings (on firestore)
                      restaurant.addRating(currentRating);
                    } else {
                      //Get the rating the of the restaurant by the user
                      int? rating = user.ratings[restaurant.uuid];

                      //Remove the previous rating from the restaurant
                      restaurant.removeRating(rating!);

                      //Add the new rating to the user's list (on firestore)
                      //This also overwrites the old rating in the process
                      user.addRating(
                        restaurant.uuid,
                        currentRating,
                      );

                      //Add the new rating to the current user as well
                      globals.ratings = user.ratings;

                      //Add the new rating to the restaurant's list (on firestore)
                      restaurant.addRating(currentRating);
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 45, 0, 5),
                child: const Text(
                  "Comments",
                  style: TextStyle(
                    fontFamily: 'Kurale',
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: const Text(
                  "Leave your comment",
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: TextField(
                  controller: comment,
                  decoration: const InputDecoration(
                    labelText: "I think this restaurant is...",
                  ),
                  autocorrect: false,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      restaurant.addComment(globals.name, comment.text);
                    });
                  },
                  child: const Text("Submit"),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: ListView.builder(
                  itemCount: restaurant.comments.keys.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(restaurant.comments.keys.elementAt(index)),
                      subtitle: Text(restaurant.comments[
                              restaurant.comments.keys.elementAt(index)] ??
                          ''),
                    );
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
