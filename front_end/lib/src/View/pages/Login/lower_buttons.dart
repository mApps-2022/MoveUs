import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end/generated/l10n.dart';
import 'package:front_end/src/Logic/bloc/LoginBloc.dart';
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
          child: FloatingActionButton.extended(
            heroTag: "login",
            backgroundColor: snapshot.hasData ? Color.fromRGBO(83, 232, 139, 1) : Colors.grey[400],
            onPressed: snapshot.hasData ? () => Auth.loginWithEmailAndPassword(context, bloc, user) : null,
            label: Text(
              S.of(context).login_button_login,
              style: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.w900),
            ),
          ),
        );
      },
    );
  }
}
