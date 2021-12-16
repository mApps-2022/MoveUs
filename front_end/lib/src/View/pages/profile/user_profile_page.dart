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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
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
                    )),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  "Métodos de pago",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w800,
                    color: Colors.black45,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                getPaymentInfo(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getPaymentInfo() {
    return Column(
      children: [
        FutureBuilder(
            future: getUserInformation(FirebaseAuth.instance.currentUser!.uid),
            builder: (BuildContext context, AsyncSnapshot<List<Object>> snapshot) {
              if (snapshot.hasData) {
                return getCards(snapshot);
              }
              return Text("Metodos no encontrados");
            })
      ],
    );
  }

  ListView getCards(AsyncSnapshot<List<Object>> snapshot) {
    List<Card> cards = snapshot.data!;
    return ListView.builder(
        shrinkWrap: true,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 10.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Image(
                        image: (cards[index].)("https://pbs.twimg.com/profile_images/1410611681303023621/HDtqy0Oq_400x400.jpg"),
                      )),
                  contentPadding: EdgeInsets.only(top: 10.0),
                  title: Text('Soy el titulo de esta tarjeta'),
                  subtitle: Text('a'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 20.0),
                      child: TextButton(
                        child: Text('Detalle'),
                        onPressed: () {},
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
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
            color: Colors.black45,
            fontSize: 30.0,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          FirebaseAuth.instance.currentUser!.email!,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w800,
            color: Colors.black45,
            fontSize: 15.0,
          ),
        )
      ],
    );
  }

  Future<List<Object>> getUserInformation(String uid) async {
    User? user = FirebaseAuth.instance.currentUser;
    List<Object> cards = [];
    CollectionReference userCards = FirebaseFirestore.instance.collection("PaymentInfo").doc(user!.uid).collection("Cards");
    await userCards.get().then((value) {
      for (QueryDocumentSnapshot<Object?> card in value.docs) {
        print("TARJEEEEETA: " + card.data().toString());
        cards.add(card.data()!);
      }
      return cards;
    });
    return cards;
  }

  void setUserInformation(UserInfo user) {
    CollectionReference payments = FirebaseFirestore.instance.collection("PaymentInfo");
    payments.doc(user.uid).set(user);
  }
}

/*
ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: cards.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Image(
                          image: NetworkImage("https://pbs.twimg.com/profile_images/1410611681303023621/HDtqy0Oq_400x400.jpg"),
                        )),
                    contentPadding: EdgeInsets.only(top: 10.0),
                    title: Text('Soy el titulo de esta tarjeta'),
                    subtitle: Text('a'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 20.0),
                        child: TextButton(
                          child: Text('Detalle'),
                          onPressed: () {},
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          })
*/