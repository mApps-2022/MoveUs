import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GoogleAuthButton(
      onPressed: () {},
      darkMode: false, // if true second example
    );
  }
}
