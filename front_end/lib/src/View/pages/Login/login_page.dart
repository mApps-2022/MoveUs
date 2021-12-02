// ignore_for_file: argument_type_not_assignable_to_error_handler

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:front_end/generated/l10n.dart';

import 'package:front_end/src/Logic/bloc/LoginBloc.dart';
import 'package:front_end/src/Logic/provider/ProvidetBlocs.dart';

import 'package:front_end/src/Logic/utils/auth_utils.dart';
import 'package:front_end/src/View/pages/Login/lower_buttons.dart';
import 'package:provider/src/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    LoginBloc loginBloc = context.read<ProviderBlocs>().login;
    return WillPopScope(
      onWillPop: () {
        return Navigator.maybePop(context);
      },
      child: Scaffold(
        body: body(context, loginBloc),
      ),
    );
  }

  Stack body(BuildContext context, LoginBloc loginBloc) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              _imageLogo(),
              Container(
                child: Text(
                  S.of(context).login_title,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'OpenSans',
                    color: Color.fromRGBO(9, 5, 28, 1),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 20),
              StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    return form(loginBloc);
                  }),
              _paddingField(ButtonsWidget(bloc: loginBloc)),
              _paddingField(_googleLoginButton(context)),
            ],
          ),
        )
      ],
    );
  }

  Container _imageLogo() {
    return Container(
      padding: EdgeInsets.only(top: 50),
      child: Center(
        child: Image.asset(
          'assets/img/logo.png',
          height: 150,
        ),
      ),
    );
  }

  Column form(LoginBloc loginBloc) {
    return Column(
      children: [
        _paddingField(_emailField(loginBloc)),
        _paddingField(_phoneField(loginBloc)),
        _paddingField(_passwordField(loginBloc)),
      ],
    );
  }

  Widget _paddingField(Widget field) {
    return Padding(padding: const EdgeInsets.only(top: 20, left: 20, right: 20), child: field);
  }

  InputDecoration _decorationField(String labelTextField, Icon iconField) {
    return InputDecoration(
      labelText: labelTextField,
      labelStyle: TextStyle(fontSize: 14, color: Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      contentPadding: EdgeInsets.all(16),
      filled: true,
      prefixIcon: iconField,
    );
  }

  Widget _emailField(LoginBloc loginBloc) {
    return TextField(
      decoration: _decorationField(
          dotenv.get('PRUEBA'),
          Icon(
            Icons.email,
            color: Colors.grey,
          )),
      onChanged: (value) => {
        loginBloc.changeEmail(value),
      },
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _phoneField(LoginBloc loginBloc) {
    return TextField(
      decoration: _decorationField(
          S.of(context).login_phone_field_label,
          Icon(
            Icons.phone,
            color: Colors.grey,
          )),
      onChanged: (value) => {
        loginBloc.changePhoneNumber(value),
      },
      obscureText: false,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter(RegExp("[0-9 \]"), allow: true)],
    );
  }

  Widget _passwordField(LoginBloc loginBloc) {
    return TextField(
      decoration: _decorationField(
          S.of(context).login_password_field_label,
          Icon(
            Icons.password,
            color: Colors.grey,
          )),
      onChanged: (value) => {
        loginBloc.changePassword(value),
      },
      obscureText: true,
    );
  }

  Widget _googleLoginButton(BuildContext context) {
    return GoogleAuthButton(
      onPressed: () {
        Auth.signInWithGoogle(context);
      },
      text: S.of(context).login_button_login_google,
      darkMode: false,
    );
  }
}
