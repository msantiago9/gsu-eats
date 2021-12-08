import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gsu_eats/models/restaurant.dart';
import 'package:gsu_eats/screens/restaurantpage.dart';
import 'package:gsu_eats/tools/dbhandler.dart';

class Popular extends StatefulWidget {
  const Popular({Key? key}) : super(key: key);

  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  List<Restaurant> list = [];

  @override
  void initState() {
    super.initState();
    populateList();
    //Get all of the restaurants from the database
    //set the list to the obtained data
  }

  void populateList() async {
    Future<List<Restaurant>> dbRestaurants = DBServ().getRestaurants();
    dbRestaurants.then((data) {
      setState(() {
        list = data;
        list.sort((a, b) {
          double avgRatingsA =
              a.ratings.reduce((value, element) => value + element) /
                  a.ratings.length;
          double avgRatingsB =
              b.ratings.reduce((value, element) => value + element) /
                  b.ratings.length;
          if (avgRatingsA < avgRatingsB) {
            return 1;
          }
          if (avgRatingsA > avgRatingsB) {
            return -1;
          }
          return 0;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular"),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                child: const Text('Most Popular Restaurants'),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                child: CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                  ),
                  items: list
                      .map((e) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Image.network(
                                e.img,
                                width: 1000,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            ],
                          )))
                      .toList(),
                ),
              ),
              ListView.builder(
                itemCount: list.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Image.network(list[index].img, width: 50),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text((list[index].ratings.reduce(
                                      (value, element) => value + element) /
                                  list[index].ratings.length)
                              .toStringAsFixed(2)),
                          const Icon(Icons.star),
                        ],
                      ),
                      title: Text(list[index].name),
                      subtitle: Text(list[index].details),
                      onTap: () async {
                        if (await DBServ().isRestaurant(list[index].name)) {
                          Restaurant restaurant =
                              await DBServ().getRestaurant(list[index].name);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RestaurantPage(restaurant: restaurant),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No restaurant found.'),
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
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
