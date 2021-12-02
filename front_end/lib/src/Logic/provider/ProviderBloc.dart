import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:front_end/src/Logic/bloc/LoginBloc.dart';
import 'package:front_end/src/Logic/bloc/TableroBloc.dart';
import 'package:front_end/src/Logic/bloc/registerBloc.dart';

class Provider extends InheritedWidget {
  final _tablero = TableroBloc();
  final _register = RegisterBloc();
  final _login = LoginBloc();
  Provider({required Key key, required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
  static TableroBloc tableroBloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!._tablero;
  }

  static RegisterBloc registerBloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!._register;
  }

  static LoginBloc loginBloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!._login;
  }
}
