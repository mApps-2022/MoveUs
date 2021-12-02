import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/src/Logic/bloc/LoginBloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:front_end/src/Logic/utils/auth_utils.dart';

class ButtonsWidget extends StatelessWidget {
  final LoginBloc bloc;
  User? user = FirebaseAuth.instance.currentUser;

  ButtonsWidget({Key? key, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.validateBasicForm,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                heroTag: "login",
                backgroundColor: snapshot.hasData ? Color.fromRGBO(83, 232, 139, 1) : Colors.grey[400],
                onPressed: snapshot.hasData ? () => Auth.loginWithEmailAndPassword(context, bloc, user) : null,
                label: Text(
                  AppLocalizations.of(context)!.login_button_login,
                  style: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(width: 20.0),
              FloatingActionButton.extended(
                heroTag: "register",
                backgroundColor: Color.fromRGBO(83, 232, 139, 1),
                onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
                label: Text(
                  AppLocalizations.of(context)!.login_button_create_account,
                  style: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
