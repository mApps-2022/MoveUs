import 'package:flutter/material.dart';

class UserInfo {
  String uid;
  String displayName;
  String photoURL;
  String email;
  List<CreditCard>? creditCards;

  UserInfo.register({
    required this.uid,
    required this.displayName,
    required this.photoURL,
    required this.email,
  });

  UserInfo.buildInfo({required this.uid, required this.displayName, required this.photoURL, required this.email, required this.creditCards});
}

class CreditCard {
  String number;
  String expDate;
  String ccv;

  CreditCard({required this.number, required this.expDate, required this.ccv});
}
