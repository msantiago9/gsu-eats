import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gsu_eats/models/restaurant.dart';

class GoogleMapsPage extends StatefulWidget {
  final Restaurant restaurant;
  const GoogleMapsPage({Key? key, required this.restaurant}) : super(key: key);
  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  late GoogleMapController mapController;

  LatLng _center = const LatLng(0.0, 0.0);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _center = LatLng(double.parse(widget.restaurant.latitude),
          double.parse(widget.restaurant.longitude));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}
