import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      //style: style,
      child: Text('Login'),
      onPressed: null,
    );
  }
}
