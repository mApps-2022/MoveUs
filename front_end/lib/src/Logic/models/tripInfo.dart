import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Trip with ChangeNotifier {
  String car;
  String date;
  String driverId;

  Trip({
    required this.car,
    required this.date,
    required this.driverId,
  });

  factory Trip.fromFirestore(DocumentSnapshot tripDoc) {
    Map tripData = tripDoc.data as Map;
    return Trip(
      car: tripData['car'],
      date: tripData['date'],
      driverId: tripData['driverId'],
    );
  }

  void setFromFireStore(DocumentSnapshot userDoc) {
    Map userData = userDoc.data as Map;
    this.car = userData['displayName'];
    this.date = userData['photoURL'];
    this.driverId = userData['email'];
    notifyListeners();
  }
}
