//import 'package:auth_buttons/auth_buttons.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:front_end/src/Logic/bloc/LoginBloc.dart';
import 'package:front_end/src/Logic/provider/ProviderBloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    LoginBloc loginBloc = Provider.loginBloc(context);
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
                  //AppLocalizations.of(context)!.register_title
                  "Ingresa a tu cuenta",
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
              _paddingField(ButtomWidget(stream: loginBloc.validateBasicForm)),
              _paddingField(_googleLoginButton()),
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
          "Correo",
          Icon(
            Icons.email,
            color: Colors.grey,
          )),
      onChanged: (value) => {
        loginBloc.changeEmail(value),
      },
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _phoneField(LoginBloc loginBloc) {
    return TextField(
      decoration: _decorationField(
          "Numero telefonico",
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
          "Password",
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

  Widget _googleLoginButton() {
    return GoogleAuthButton(
      onPressed: () {},
      text: 'Iniciar sesión con Google',
      darkMode: false,
    );
  }
}

class ButtomWidget extends StatelessWidget {
  const ButtomWidget({
    Key? key,
    required this.stream,
  }) : super(key: key);

  final Stream stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                backgroundColor: snapshot.hasData ? Color.fromRGBO(83, 232, 139, 1) : Colors.grey[400],
                onPressed: snapshot.hasData ? () => print('Hace login') : null,
                label: Text('Iniciar sesión'),
              ),
              SizedBox(width: 20.0),
              FloatingActionButton.extended(
                backgroundColor: Color.fromRGBO(83, 232, 139, 1),
                onPressed: () => print('pasa register'),
                label: Text('Crear Cuenta'),
              ),
            ],
          ),
        );
      },
    );
  }
}
