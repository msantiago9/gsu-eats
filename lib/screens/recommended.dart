import 'package:flutter/material.dart';
import 'package:gsu_eats/models/restaurant.dart';
import 'package:gsu_eats/models/globals.dart' as globals;
import 'package:gsu_eats/screens/restaurantpage.dart';
import 'package:gsu_eats/tools/dbhandler.dart';

class Recommended extends StatefulWidget {
  const Recommended({Key? key}) : super(key: key);

  @override
  _RecommendedState createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  List<Restaurant> list = [];

  @override
  void initState() {
    super.initState();
    List<String> uuids = [];
    for (String element in globals.ratings.keys) {
      uuids.add(element);
    }
    print(uuids);
    populateList(uuids);
  }

  void populateList(uuids) async {
    DBServ dbserv = DBServ();
    List<Restaurant> temp = [];
    for (String uuid in uuids) {
      if (await dbserv.isRestaurantByUUID(uuid)) {
        temp.add(await dbserv.getRestaurantByUUID(uuid));
      }
    }
    setState(() {
      list = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommended"),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Text(
              "Favorites!",
              style: TextStyle(
                fontFamily: 'Kurale',
                fontSize: 20,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 15, 10, 15),
              child: ListView.builder(
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
                              //.toString()
                              .toStringAsFixed(2)), //Two decimal places round
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
