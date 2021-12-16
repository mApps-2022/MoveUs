import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:front_end/src/Logic/bloc/LocationBloc.dart';

import 'package:front_end/src/Logic/provider/ProviderBlocs.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/src/provider.dart';

class TravelHistoryDetail extends StatefulWidget {
  TravelHistoryDetail({Key? key}) : super(key: key);

  @override
  _TravelHistoryDetailState createState() => _TravelHistoryDetailState();
}

class _TravelHistoryDetailState extends State<TravelHistoryDetail> {
  late Marker markerOrigin;
  late Marker markerDestiny;
  late LocationBloc locationBloc;
  Completer<GoogleMapController> _controller = Completer();
  Location location = new Location();
  bool updateCamera = true;
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  double destinylatitude = 9.647960;
  double destinylongitude = -74.089647;

  @override
  void initState() {
    polylinePoints = PolylinePoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    locationBloc = context.read<ProviderBlocs>().location;
    markerOrigin = Marker(
      markerId: MarkerId('origin'),
      infoWindow: InfoWindow(title: 'Origin'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      position: LatLng(locationBloc.currentloc!.latitude!, locationBloc.currentloc!.longitude!),
    );
    markerDestiny = Marker(
      markerId: MarkerId('destiny'),
      infoWindow: InfoWindow(title: 'Destiny'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: LatLng(destinylatitude, destinylongitude),
    );
    return WillPopScope(
      onWillPop: () {
        return Navigator.maybePop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, 'home');
            },
            child: Icon(
              Icons.arrow_back_ios_new, // add custom icons also
            ),
          ),
          backgroundColor: Colors.white54,
          elevation: 2,
        ),
        body: body(context),
        //bottomNavigationBar: bottonRegister(registerBloc),
      ),
    );
  }

  body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double fontSize = 11;
    FontWeight fontWeight = FontWeight.w400;
    double cameraLatitude = (locationBloc.currentloc!.latitude! + destinylatitude) / 2;
    double cameraLongitude = (locationBloc.currentloc!.longitude! + destinylongitude) / 2;
    print(size.height / 9);
    return Stack(children: [
      GoogleMap(
        //myLocationEnabled: true,
        compassEnabled: false,
        mapType: MapType.normal,
        markers: {markerOrigin, markerDestiny},
        polylines: _polylines,
        initialCameraPosition: CameraPosition(
          target: LatLng(cameraLatitude, cameraLongitude),
          zoom: calculateZoom(),
        ),
        onMapCreated: (GoogleMapController mapController) {
          setPolylines();
        },
      ),
      Positioned.fill(
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            height: size.height / 9,
            width: size.height / 9,
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset('assets/img/Photo.png'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            ),
          ),
        ),
      ),
      Positioned(
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            decoration: BoxDecoration(
              //backgroundBlendMode: BlendMode.color,
              borderRadius: BorderRadius.circular(16.0),
              color: Color.fromRGBO(255, 255, 255, 0.8),
            ),
            margin: EdgeInsets.only(bottom: 5, left: 5, top: size.height / 9),
            height: 150,
            width: 160,
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nombre',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontFamily: 'OpenSans',
                              color: Color.fromRGBO(9, 5, 28, 1),
                              fontWeight: fontWeight,
                            ),
                          ),
                          Text(
                            'Marca',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontFamily: 'OpenSans',
                              color: Color.fromRGBO(9, 5, 28, 1),
                              fontWeight: fontWeight,
                            ),
                          ),
                          Text(
                            'Modelo',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontFamily: 'OpenSans',
                              color: Color.fromRGBO(9, 5, 28, 1),
                              fontWeight: fontWeight,
                            ),
                          ),
                          Text(
                            'Color',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontFamily: 'OpenSans',
                              color: Color.fromRGBO(9, 5, 28, 1),
                              fontWeight: fontWeight,
                            ),
                          ),
                          Text(
                            'Calificacion',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontFamily: 'OpenSans',
                              color: Color.fromRGBO(9, 5, 28, 1),
                              fontWeight: fontWeight,
                            ),
                          ),
                          Text(
                            'origen',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontFamily: 'OpenSans',
                              color: Color.fromRGBO(9, 5, 28, 1),
                              fontWeight: fontWeight,
                            ),
                          ),
                          Text(
                            'destino',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontFamily: 'OpenSans',
                              color: Color.fromRGBO(9, 5, 28, 1),
                              fontWeight: fontWeight,
                            ),
                          ),
                          Text(
                            'valor',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontFamily: 'OpenSans',
                              color: Color.fromRGBO(9, 5, 28, 1),
                              fontWeight: fontWeight,
                            ),
                          ),
                          Text(
                            'pago',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontFamily: 'OpenSans',
                              color: Color.fromRGBO(9, 5, 28, 1),
                              fontWeight: fontWeight,
                            ),
                          ),
                          Text(
                            'id',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontFamily: 'OpenSans',
                              color: Color.fromRGBO(9, 5, 28, 1),
                              fontWeight: fontWeight,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Marcos',
                              style: TextStyle(
                                fontSize: fontSize,
                                fontFamily: 'OpenSans',
                                color: Color.fromRGBO(9, 5, 28, 1),
                                fontWeight: fontWeight,
                              ),
                            ),
                            Text(
                              'volkswagen',
                              style: TextStyle(
                                fontSize: fontSize,
                                fontFamily: 'OpenSans',
                                color: Color.fromRGBO(9, 5, 28, 1),
                                fontWeight: fontWeight,
                              ),
                            ),
                            Text(
                              '2020',
                              style: TextStyle(
                                fontSize: fontSize,
                                fontFamily: 'OpenSans',
                                color: Color.fromRGBO(9, 5, 28, 1),
                                fontWeight: fontWeight,
                              ),
                            ),
                            Text(
                              'Azul',
                              style: TextStyle(
                                fontSize: fontSize,
                                fontFamily: 'OpenSans',
                                color: Color.fromRGBO(9, 5, 28, 1),
                                fontWeight: fontWeight,
                              ),
                            ),
                            Text(
                              '5.0',
                              style: TextStyle(
                                fontSize: fontSize,
                                fontFamily: 'OpenSans',
                                color: Color.fromRGBO(9, 5, 28, 1),
                                fontWeight: fontWeight,
                              ),
                            ),
                            Text(
                              'Cl 159a #13a-46',
                              style: TextStyle(
                                fontSize: fontSize,
                                fontFamily: 'OpenSans',
                                color: Color.fromRGBO(9, 5, 28, 1),
                                fontWeight: fontWeight,
                              ),
                            ),
                            Text(
                              'Cl 105 #69-76',
                              style: TextStyle(
                                fontSize: fontSize,
                                fontFamily: 'OpenSans',
                                color: Color.fromRGBO(9, 5, 28, 1),
                                fontWeight: fontWeight,
                              ),
                            ),
                            Text(
                              '2000',
                              style: TextStyle(
                                fontSize: fontSize,
                                fontFamily: 'OpenSans',
                                color: Color.fromRGBO(9, 5, 28, 1),
                                fontWeight: fontWeight,
                              ),
                            ),
                            Text(
                              'Efectivo',
                              style: TextStyle(
                                fontSize: fontSize,
                                fontFamily: 'OpenSans',
                                color: Color.fromRGBO(9, 5, 28, 1),
                                fontWeight: fontWeight,
                              ),
                            ),
                            Text(
                              '123456',
                              style: TextStyle(
                                fontSize: fontSize,
                                fontFamily: 'OpenSans',
                                color: Color.fromRGBO(9, 5, 28, 1),
                                fontWeight: fontWeight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    ]);
  }

  void setPolylines() async {
    PolylineResult polylineResult = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyCDZAwBVPXSnRc3EcBQshSeASpT_NzQ28k',
      PointLatLng(locationBloc.currentloc!.latitude!, locationBloc.currentloc!.longitude!),
      PointLatLng(destinylatitude, destinylongitude),
    );
    print(polylineResult.status);
    if (polylineResult.status == 'OK') {
      polylineResult.points.forEach((PointLatLng point) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      });
      setState(() {
        _polylines.add(Polyline(
          width: 3,
          polylineId: PolylineId('polyline'),
          color: Colors.blue,
          points: polylineCoordinates,
        ));
      });
    }
  }

  double calculateZoom() {
    double zoom = 14;
    double diferenceLatitude = (locationBloc.currentloc!.latitude! - destinylatitude).abs();
    double diferenceLongitutude = (locationBloc.currentloc!.longitude! - destinylongitude).abs();
    late double maxDiff;
    diferenceLatitude > destinylongitude ? maxDiff = diferenceLatitude : maxDiff = diferenceLongitutude;
    print(diferenceLatitude);
    print(diferenceLongitutude);
    if (maxDiff > 1) {
      return zoom / maxDiff;
    }
    if (maxDiff > 0.1) {
      return zoom / (maxDiff + 1);
    }
    return zoom;
  }
}
