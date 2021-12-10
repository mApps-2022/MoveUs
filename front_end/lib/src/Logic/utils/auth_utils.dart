import 'dart:io';
import 'dart:typed_data';

import 'package:front_end/generated/l10n.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:front_end/src/Logic/bloc/LoginBloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  static Future<User?> loginWithEmailAndPassword(BuildContext context, LoginBloc bloc, User? user) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: bloc.email!,
        password: bloc.password!,
      )
          .then((value) {
        Navigator.pushNamed(context, 'home');
        String? email = value.user?.email;
        bloc.changeUserState(email!);
      });
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (error.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static Future<User?> signUp(BuildContext context, {required email, required displayName, required password}) async {
    try {
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
        print("Retorno: $value");
        User? currentUser = FirebaseAuth.instance.currentUser;
        currentUser?.updateDisplayName(displayName);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<UserCredential> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    print("Valores retornados : ${googleUser?.authentication.toString()}");

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<String> uploadProfilePicture(BuildContext context, File imageFile) async {
    String fileName = basename(imageFile.path);
    final destination = 'files/$fileName';
    try {
      Reference database = FirebaseStorage.instance.ref(destination);
      firebase_storage.TaskSnapshot uploadTask = await database.putFile(imageFile);
      var dowurl = await uploadTask.ref.getDownloadURL();
      String url = dowurl.toString();
      return url;
    } on FirebaseException catch (e) {
      print("ERROR" + e.toString());
      return "ERROR";
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      print("ERROR" + e.toString());
      return null;
    }
  }

  static void setCarInformation({required String uid, required String placa, required String color, required String modelo}) {
    CollectionReference cars = FirebaseFirestore.instance.collection('Cars');

    cars.doc(uid).set({
      'placa': placa,
      'color': color,
      'modelo': modelo,
    }).then((value) => print("Valor de retorno de la base de datos: retorno BD"))
      ..catchError((e) => print("Error subiendo la información del vehículo: $e"));
  }

  static void getCarInformation(String uid) {
    CollectionReference cars = FirebaseFirestore.instance.collection('Cars');
    Future<DocumentSnapshot<Object?>> carInfo = cars.doc(uid).get();
    carInfo.then((value) => print("GET INFORMATION: $value"));
  }

  static User getUser() {
    return FirebaseAuth.instance.currentUser!;
  }
}
