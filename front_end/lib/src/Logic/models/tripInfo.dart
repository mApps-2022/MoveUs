import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Trip with ChangeNotifier {
  final String car;
  final Timestamp date;
  final String driverId;
  Trip({required this.car, required this.date, required this.driverId});

  Trip.fromJson(Map<dynamic, dynamic> json)
      : car = json['car'],
        date = json['date'],
        driverId = json['driverId'];

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'car': car,
        'date': date,
        'driverId': driverId,
      };
}
