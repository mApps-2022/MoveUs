import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  int  _indexseleccionado=0;
  PageController pageController= new PageController();
  void _onItemTapped(int index) {
    setState(() {
      _indexseleccionado = index;
    });
  }
  Completer<GoogleMapController> _controller = Completer();


  double latitude = 4.72;
  double longitude = -72.76;

  Location location = new Location();


  @override
  void initState() {
    getLocation();
  }

  Future<void> getLocation() async{


  bool _serviceEnabled;
  PermissionStatus _permissionGranted;


  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  LocationData _currentPosition = await location.getLocation();
  latitude =  _currentPosition.latitude!.toDouble();
  longitude= _currentPosition.longitude!.toDouble();

}



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude,longitude),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          location.onLocationChanged.listen((l) {controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(l.latitude!.toDouble(), l.longitude!.toDouble()),zoom: 15),
            ),
          ); });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(items: const<BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home),
        label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Carrro'),
        BottomNavigationBarItem(icon: Icon(Icons.message_rounded), label: 'Mensajes')
      ],
        currentIndex: _indexseleccionado,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

}