import 'dart:async';
import 'package:flutter/material.dart';
import 'package:front_end/src/Logic/bloc/LocationBloc.dart';
import 'package:front_end/src/Logic/provider/ProviderBlocs.dart';
import 'package:front_end/src/View/widgets/shared/form/Sidebar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class CreateRoute extends StatefulWidget {
  @override
  State<CreateRoute> createState() => CreateRouteState();
}

class CreateRouteState extends State<CreateRoute> {
  int _indexseleccionado = 1;
  PageController pageController = new PageController();
  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, 'home');
    }
    if (index == 2) {
      Navigator.pushReplacementNamed(context, 'tripHistory');
    }
    setState(() {
      _indexseleccionado = index;
    });
  }

  Completer<GoogleMapController> _controller = Completer();

  double latitude = 4.72;
  double longitude = -72.76;

  double firstLatitude = 4.72;
  double firstLongitude = -72.76;

  late double secondLatitude;
  late double secondLongitude;

  bool second = false;
  bool firstTime = true;

  Location location = new Location();

  bool updateCamera = true;

  String apiKey = "AIzaSyCyUIspY4Gs4B9chabJmvHw06Rzy6lWEVk";

  Set<Marker> markers = Set();

  // this will hold the generated polylines
  Set<Polyline> polylines = {};
// this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];
// this is the key object - the PolylinePoints
// which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    getLocation();
  }

  Future<void> getLocation() async {
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
    latitude = _currentPosition.latitude!.toDouble();
    longitude = _currentPosition.longitude!.toDouble();
  }

  setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey, // Google Maps API Key
        PointLatLng(firstLatitude, firstLongitude),
        PointLatLng(secondLatitude, secondLongitude),
        travelMode: TravelMode.driving);
    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      });
      setState(() {
        polylines.add(Polyline(
          width: 3,
          polylineId: PolylineId('polyline'),
          color: Colors.blue,
          points: polylineCoordinates,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    LocationBloc locationbloc = context.read<ProviderBlocs>().location;
    return new Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: Text('Crear Ruta'),
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        compassEnabled: false,
        mapType: MapType.normal,
        markers: markers,
        polylines: polylines,
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          location.onLocationChanged.listen((l) {
            locationbloc.changeCurrentloc(l);
            if (firstTime) {
              Marker resultMarker = Marker(
                markerId: MarkerId("me"),
                infoWindow: InfoWindow(title: "me", snippet: "me"),
                position: LatLng(locationbloc.currentloc!.latitude!.toDouble(), locationbloc.currentloc!.longitude!.toDouble()),
              );
              markers.add(resultMarker);
              firstTime = false;
            }
// Add it to Set

            if (updateCamera) {
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(target: LatLng(locationbloc.currentloc!.latitude!.toDouble(), locationbloc.currentloc!.longitude!.toDouble()), zoom: 15),
                ),
              );
              updateCamera = false;
            }
          });
        },
        onTap: (LatLng latLng) {
          setState(() {
            if (second) {
              secondLatitude = firstLatitude;
              secondLongitude = firstLongitude;
            }
            firstLatitude = latLng.latitude;
            firstLongitude = latLng.longitude;

            markers.add(Marker(
              markerId: MarkerId(latLng.toString()),
              position: LatLng(firstLatitude, firstLongitude),
            ));

            if (second) {
              setPolylines();
            } else {
              second = true;
            }
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
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
