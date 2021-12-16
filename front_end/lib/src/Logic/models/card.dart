import 'package:flutter/cupertino.dart';

class CreditCard {
  String Brand;
  String ccv;
  String expDate;
  String number;

  CreditCard(this.Brand, this.ccv, this.expDate, this.number);

  CreditCard.fromJson(Map<dynamic, dynamic> json)
      : Brand = json['Brand'],
        ccv = json['ccv'],
        expDate = json['expDate'],
        number = json['number'];

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{'Brand': Brand, 'ccv': ccv, 'expDate': expDate, 'number': number};
}
