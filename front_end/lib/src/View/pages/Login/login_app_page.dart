import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
