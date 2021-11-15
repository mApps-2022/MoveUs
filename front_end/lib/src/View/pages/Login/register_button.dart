import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      //style: style,
      child: Text('Create account'),
      onPressed: null,
    );
  }
}
