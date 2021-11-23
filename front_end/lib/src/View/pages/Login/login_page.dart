//import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:front_end/src/Logic/bloc/LoginBloc.dart';
import 'package:front_end/src/Logic/bloc/ProviderBloc.dart';

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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ButtomWidget(stream: loginBloc.validateBasicForm),
        ),
      ),
    );
  }

  Stack body(BuildContext context, LoginBloc loginBloc) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                  child: Image.asset(
                    'assets/img/logo.png',
                    height: 150,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    return form(loginBloc);
                  })
            ],
          ),
        )
      ],
    );
  }

  Column form(LoginBloc loginBloc) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: TextField(
            decoration: InputDecoration(
              //hintText: "Your Name",
              labelText: "Correo",
              labelStyle: TextStyle(fontSize: 14, color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              //disabledBorder: InputBorder.none,
              //fillColor: Colors.black12,
              contentPadding: EdgeInsets.all(16),
              filled: true,

              prefixIcon: Icon(
                Icons.email,
                color: Colors.grey,
              ),
            ),
            onChanged: (value) => {
              loginBloc.changeEmail(value),
            },
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            //maxLength: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: TextField(
            decoration: InputDecoration(
              //hintText: "Your Name",
              labelText: "Numero telefonico",
              labelStyle: TextStyle(fontSize: 14, color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              //disabledBorder: InputBorder.none,
              //fillColor: Colors.black12,
              contentPadding: EdgeInsets.all(16),
              filled: true,

              prefixIcon: Icon(
                Icons.phone,
                color: Colors.grey,
              ),
            ),
            onChanged: (value) => {
              loginBloc.changePhoneNumber(value),
            },
            obscureText: false,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter(RegExp("[0-9 \]"), allow: true)],
            //maxLength: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: TextField(
            decoration: InputDecoration(
              //hintText: "Your Name",
              labelText: "Contraseña",
              labelStyle: TextStyle(fontSize: 14, color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              //disabledBorder: InputBorder.none,
              //fillColor: Colors.black12,
              contentPadding: EdgeInsets.all(16),
              filled: true,

              prefixIcon: Icon(
                Icons.password,
                color: Colors.grey,
              ),

              //icon: Icon(Icons.person),
            ),
            onChanged: (value) => {
              loginBloc.changePassword(value),
            },
            obscureText: true,
            //maxLength: 20,
          ),
        ),
      ],
    );
  }
}

class AppLocalizations {}

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
          child: FloatingActionButton.extended(
            backgroundColor: snapshot.hasData ? Color.fromRGBO(83, 232, 139, 1) : Colors.grey[400],
            onPressed: snapshot.hasData ? () => print('pasa') : null,
            label: Text('Crear Cuenta'),
          ),
        );
      },
    );
  }
}
/*
class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _logoImage(),
                _loginText(),
                _loginForm(),
                _singInWith(),
                _googleLoginButton(),
                _forgotPassword(),
              ],
            )));
  }

  Widget _loginForm() {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _emailField(),
          _passwordField(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _loginButton(),
              SizedBox(width: 10.0),
              _registerButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _logoImage() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Image.asset(
        'assets/img/logo.png',
        height: 150,
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      decoration: InputDecoration(icon: Icon(Icons.email), labelText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      validator: (value) => null,
    );
  }

  Widget _passwordField() {
    return TextFormField(
      decoration: InputDecoration(icon: Icon(Icons.lock), labelText: 'Password'),
      obscureText: true,
      validator: (value) => null,
    );
  }

  Widget _loginButton() {
    return ElevatedButton(
      //style: style,
      child: Text('Iniciar sesión'),
      onPressed: null,
    );
  }

  Widget _googleLoginButton() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: GoogleAuthButton(
        onPressed: () {},
        text: 'Iniciar sesión con Google',
        darkMode: false, // if true second example
      ),
    );
  }

  Widget _registerButton() {
    return ElevatedButton(
      //style: style,
      child: Text('Crear cuenta'),
      onPressed: null,
    );
  }

  Widget _loginText() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Text('Ingresa a tu cuenta'),
    );
  }

  Widget _singInWith() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Text('O ingresa Con'),
    );
  }

  Widget _forgotPassword() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Text('¿Olvidó su contraseña?'),
    );
  }
}
*/