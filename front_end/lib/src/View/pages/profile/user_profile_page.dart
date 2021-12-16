import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String photo = FirebaseAuth.instance.currentUser!.photoURL!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.black12, width: 2.0), borderRadius: BorderRadius.circular(20.0)),
            child: Center(
              child: Image(
                image: NetworkImage(photo),
                width: 350,
                height: 350,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: getTextInfo(),
              ))
        ],
      ),
    );
  }

  Widget getTextInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          FirebaseAuth.instance.currentUser!.displayName!,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w800,
            color: Colors.amber,
            fontSize: 30.0,
          ),
        ),
        Text(FirebaseAuth.instance.currentUser!.email!)
      ],
    );
  }

  void getUserInformation(String uid) async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference userCards = FirebaseFirestore.instance.collection("PaymentInfo").doc(user!.uid).collection("Cards");
    await userCards.get().then((value) {
      print("\n ${user.displayName} \n");
      print("Informacion de usuario" + value.docs.first.data().toString());
    });
  }

  void setUserInformation(UserInfo user) {
    CollectionReference payments = FirebaseFirestore.instance.collection("PaymentInfo");
    payments.doc(user.uid).set(user);
  }
}
