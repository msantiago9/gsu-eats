import 'package:flutter/material.dart';
import 'package:gsu_eats/screens/popular.dart';
import 'package:gsu_eats/screens/recommended.dart';
import 'package:gsu_eats/screens/admin.dart';
import 'package:gsu_eats/screens/search.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 190,
          width: 500,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/banner.jpg'),
              fit: BoxFit.fill,
            ),
            //shape: BoxShape.circle,
          ),
          // margin: const EdgeInsets.fromLTRB(0, 5, 0, 15),
          // child: const Text(
          //   "Hello!",
          //   style: TextStyle(
          //     fontFamily: 'Kurale',
          //     fontSize: 20,
          //   ),
          // ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          width: 380,
          height: 45.0,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Search(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.green,
              onSurface: Colors.blue,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
            ),
            label: const Text('Find Somewhere To Eat',
                style: TextStyle(color: Colors.blueGrey)),
            icon: const Icon(
              Icons.search,
              color: Colors.red,
              size: 20.0,
            ),
          ),
        ),
        Column(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.fastfood),
              color: Colors.red,
              tooltip: 'Popular',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Popular(),
                  ),
                );
              },
            ),
            const Text('Popular'),
            IconButton(
              icon: const Icon(Icons.favorite),
              color: Colors.red,
              tooltip: 'Recommended',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Recommended(),
                  ),
                );
              },
            ),
            const Text('Favorites'),
            IconButton(
              icon: const Icon(Icons.library_add),
              color: Colors.red,
              tooltip: 'Add a Restaurant',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Admin(),
                  ),
                );
              },
            ),
            const Text('Add a Location'),
          ],
        ),
      ],
    );
  }
}
