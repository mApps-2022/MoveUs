import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/src/Logic/bloc/LoginBloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  static Future<User?> signUp(BuildContext context, LoginBloc bloc, User? user) async {
    try {
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: bloc.email!, password: bloc.password!).then((value) {
        print("Retorno: $value");
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
}
