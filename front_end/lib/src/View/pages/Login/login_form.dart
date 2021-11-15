import 'package:flutter/material.dart';
import 'package:front_end/src/View/pages/Login/google_login_button.dart';
import 'package:front_end/src/View/pages/Login/login_button.dart';
import 'package:front_end/src/View/pages/Login/register_button.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Form(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Image.asset(
                'assets/img/logo.png',
                height: 200,
              ),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(icon: Icon(Icons.email), labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(icon: Icon(Icons.lock), labelText: 'Password'),
              obscureText: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [LoginButton(), GoogleLoginButton(), RegisterButton()],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onEmailChanged() {}

  void _onPasswordChanged() {}
}
