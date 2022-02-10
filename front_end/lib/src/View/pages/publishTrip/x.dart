import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  void getUserInformation() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentReference Rutas_usuario = FirebaseFirestore.instance.collection("Rutas").doc(user!.uid);
    await Rutas_usuario.get().then((value) {
        viajes=(value.data() as Map<String, Object>)!;
        crearPuntos();
    });

  }

  void crearPuntos(){
    if(firstTime){
      for(int i =0;i<viajes.length;i++){
        Map<String,Object> ruta=viajes[i.toString()] as Map<String, Object>;
        Map<String,Object> puntos=ruta['puntos'] as Map<String, Object>;
        List<dynamic>? inicio=puntos['0'] as List?;
        LatLng inicio1= LatLng(inicio![0],inicio![1]);
        print('---------dasdsadas-------------------------------------------------------------');
        print(inicio1);
        markers.add(Marker(
          markerId: MarkerId(inicio1.toString()),
          position: inicio1,
        ));
        List<dynamic>? inicio2=puntos[(puntos.length-1).toString()] as List?;
        print((ruta.length-1).toString());
        LatLng inicio3= LatLng(inicio2![0],inicio2![1]);
        print('---------dasdsadas-------------------------------------------------------------');
        print(inicio3);
        markers.add(Marker(
          markerId: MarkerId(inicio3.toString()),
          position: inicio3,
        ));
        List<LatLng> listapuntos=[];
        for(int i=0;i<puntos.length;i++){
          List<dynamic>? inicio2=puntos[i.toString()] as List?;
          LatLng inicio3= LatLng(inicio2![0],inicio2![1]);
          listapuntos.add(inicio3);
        }
        polylineCoordinatesList.add(listapuntos);
        polylines.add(Polyline(
          width: 3,
          polylineId: PolylineId(polylines.length.toString()) ,
          color: Colors.blue,
          points: polylineCoordinatesList[polylines.length],
        ));
        _controller.isCompleted;
      }

    }
  }

  static void setRutaInformation({ required Map<String,Object> viajes}) {
    CollectionReference rutas = FirebaseFirestore.instance.collection('Rutas');
    User? user = FirebaseAuth.instance.currentUser;

    rutas.doc(user!.uid).set(viajes).then((value) => print("Valor de retorno de la base de datos: retorno BD"))
      ..catchError((e) => print("Error subiendo la información del viaje: $e"));
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay horaElegida =TimeOfDay.now();

  Completer<GoogleMapController> _controller = Completer();

  double latitude = 4.72;
  double longitude = -72.76;
  Map<String,Object> viajes={};

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
  List<List<LatLng>>polylineCoordinatesList=[];
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
    List<LatLng> cooraux = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey, // Google Maps API Key
        PointLatLng(firstLatitude, firstLongitude),
        PointLatLng(secondLatitude, secondLongitude),
        travelMode: TravelMode.driving);
    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        cooraux.add(
          LatLng(point.latitude, point.longitude),
        );
      });

      polylineCoordinatesList.add(cooraux);




      setState(() {
        polylines.add(Polyline(
          width: 3,
          polylineId: PolylineId(polylines.length.toString()) ,
          color: Colors.blue,
          points: polylineCoordinatesList[polylines.length],
        ));
      });




      final DateTime? picked = await showDatePicker(
          context: context,

          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null )
        setState(() {
          selectedDate = picked;
        });

      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now());
      if (newTime != null )
      setState(() {
        horaElegida = newTime;
      }
      );

      Duration duracion=Duration(hours: newTime!.hour,minutes: newTime!.minute);

      DateTime auxFecha=selectedDate.add(duracion);
      print(auxFecha);
      Map<String,Object> puntos={};
      int index=0;
      polylineCoordinatesList[polylines.length-1].forEach((element) {
        puntos.putIfAbsent(index.toString(), () => element.toJson());
        index++;
      });
      Map<String,Object> rutaActual={
        'fecha_hora':auxFecha,
        'puntos':puntos
      };


      viajes.putIfAbsent((polylines.length-1).toString(), () => rutaActual);

      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Alerta publicar viaje'),
          content: const Text('¿deseas publicar viaje?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => {
                viajes.remove((polylines.length-1).toString()),
                Navigator.pop(context, 'Cancelar')},
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => {
                setRutaInformation(viajes: viajes),
                Navigator.pop(context, 'Sí')},
              child: const Text('Sí'),
            ),
          ],
        ),
      );
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
          getUserInformation();


          print(viajes.length);
          _controller.complete(controller);
          location.onLocationChanged.listen((l) {

            locationbloc.changeCurrentloc(l);
            if (firstTime) {
              Marker resultMarker = Marker(
                markerId: MarkerId("me"),
                infoWindow: InfoWindow(title: "me", snippet: "me"),
                position: LatLng(locationbloc.currentloc!.latitude!.toDouble(),
                    locationbloc.currentloc!.longitude!.toDouble()),
              );
              markers.add(resultMarker);
              firstTime = false;
            }
// Add it to Set

            if (updateCamera) {
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(target: LatLng(
                      locationbloc.currentloc!.latitude!.toDouble(),
                      locationbloc.currentloc!.longitude!.toDouble()),
                      zoom: 15),
                ),
              );
              updateCamera = false;
            }


          }


          );




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
              second=false;
              selectedDate = DateTime.now();
              polylineCoordinates.clear();

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
