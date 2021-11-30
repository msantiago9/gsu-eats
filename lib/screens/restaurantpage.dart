import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gsu_eats/models/restaurant.dart';

class RestaurantPage extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurantPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  _RestaurantState createState() => _RestaurantState();
}

class _RestaurantState extends State<RestaurantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Text(
                '- ' + widget.restaurant.name + ' -',
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
              child: Image.asset(
                "assets/gsulogo.png",
                height: 150,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              //ToDO: replace asset with widget.restaurant.image
              //Which means restaurant classs needs a final String image
              child: RatingBar.builder(
                initialRating: (widget.restaurant.ratings
                        .reduce((value, element) => value + element) /
                    widget.restaurant.ratings.length),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
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
              child: const Text(
                "^ Average Rating",
                style: TextStyle(
                  fontFamily: 'Kurale',
                  fontSize: 20,
                ),
              ),
            ),
          ],
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
