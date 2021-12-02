import 'package:flutter/material.dart';
import 'package:front_end/src/Logic/bloc/LoginBloc.dart';
import 'package:front_end/src/Logic/provider/ProviderBloc.dart';

class HomeTest extends StatelessWidget {
  const HomeTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginBloc loginBloc = Provider.loginBloc(context);

    return StreamBuilder(
      stream: loginBloc.userStateStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Scaffold(
          appBar: AppBar(title: snapshot.hasData ? Text("Bienvenido ${snapshot.data}") : Text("No iniciado")),
        );
      },
    );
  }
}
