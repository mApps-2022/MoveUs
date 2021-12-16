import 'package:flutter/cupertino.dart';
import 'package:front_end/src/Logic/bloc/ForgotPassBloc.dart';
import 'package:front_end/src/Logic/bloc/LocationBloc.dart';
import 'package:front_end/src/Logic/bloc/LoginBloc.dart';
import 'package:front_end/src/Logic/bloc/registerBloc.dart';

class ProviderBlocs {
  RegisterBloc register = RegisterBloc();
  LoginBloc login = LoginBloc();
  ForgotPassBloc forgotPass = ForgotPassBloc();
  LocationBloc location = LocationBloc();
}
