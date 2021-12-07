import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gsu_eats/models/restaurant.dart';
import 'package:latlong2/latlong.dart';

class MapsPage extends StatefulWidget {
  final Restaurant restaurant;
  const MapsPage({Key? key, required this.restaurant}) : super(key: key);
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(double.parse(widget.restaurant.latitude),
              double.parse(widget.restaurant.longitude)),
          zoom: 18.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/smuggod123/ckwvkf4mz2mz214pk79jdjh21/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic211Z2dvZDEyMyIsImEiOiJja3d2azd5MGUxYXVhMnZteXR3MHk2bDl5In0.vK9uHcaJ0754TZvlysmfIA",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1Ijoic211Z2dvZDEyMyIsImEiOiJja3d2azd5MGUxYXVhMnZteXR3MHk2bDl5In0.vK9uHcaJ0754TZvlysmfIA'
            },
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(double.parse(widget.restaurant.latitude),
                    double.parse(widget.restaurant.longitude)),
                builder: (ctx) =>
                    const Icon(Icons.location_on_sharp, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
