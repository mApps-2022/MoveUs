import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.maybePop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('title'),
        ),
        body: Center(
          child: TextButton(
            child: Text("Entrar al login"),
            onPressed: () => Navigator.pushNamed(context, 'test'),
          ),
        ),
      ),
    );
  }
}
