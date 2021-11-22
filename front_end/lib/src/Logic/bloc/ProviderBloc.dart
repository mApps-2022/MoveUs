import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:front_end/src/Logic/bloc/TableroBloc.dart';
import 'package:front_end/src/Logic/bloc/registerBloc.dart';

class Provider extends InheritedWidget {
  final _tablero = TableroBloc();
  final _register = RegisterBloc();
  Provider({required Key key, required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
  static TableroBloc tableroBloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!._tablero;
  }

  static RegisterBloc registerBloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!._register;
  }
}
