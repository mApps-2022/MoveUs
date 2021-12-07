// ignore_for_file: argument_type_not_assignable_to_error_handler

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:front_end/generated/l10n.dart';
import 'package:front_end/src/Logic/bloc/ForgotPassBloc.dart';

import 'package:front_end/src/Logic/bloc/LoginBloc.dart';
import 'package:front_end/src/Logic/provider/ProviderBlocs.dart';

import 'package:front_end/src/Logic/utils/auth_utils.dart';
import 'package:front_end/src/View/pages/Login/lower_buttons.dart';
import 'package:front_end/src/View/widgets/shared/utils/button_widget.dart';
import 'package:provider/src/provider.dart';

class ForgotPassPage extends StatefulWidget {
  ForgotPassPage({Key? key}) : super(key: key);

  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  @override
  Widget build(BuildContext context) {
    ForgotPassBloc forgotPassBloc = context.read<ProviderBlocs>().forgotPass;
    return WillPopScope(
      onWillPop: () {
        return Navigator.maybePop(context);
      },
      child: Scaffold(
        body: body(context, forgotPassBloc),
      ),
    );
  }

  Stack body(BuildContext context, ForgotPassBloc forgotPassBloc) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              _imageLogo(),
              Container(
                child: Text(
                  //S.of(context).login_title,
                  'Recover password',
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
                    return form(forgotPassBloc);
                  }),
              _loginTextButton(),
              ButtomWidget(
                //stream: forgotPassBloc.validateBasicForm,
                stream: null,
                function: () => {
                  //Auth.signUp(context, email: registerBloc.email!, password: forgotPassBloc.password!),
                  //Navigator.pushReplacementNamed(context, 'register/foto'),
                },
                text: S.of(context).continue_label,
                enebleColor: Color.fromRGBO(83, 232, 139, 1),
                disableColor: Colors.grey[400]!,
              ),
              _createAccount(),
            ],
          ),
        )
      ],
    );
  }

  Container _loginTextButton() {
    TextStyle linkStyle = TextStyle(
      fontSize: 14,
      fontFamily: 'OpenSans',
      color: Color.fromRGBO(83, 232, 139, 1),
      fontWeight: FontWeight.w400,
    );
    return Container(
      padding: EdgeInsets.only(top: 10, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: 'Do you want to login?',
                    style: linkStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacementNamed(context, '/');
                      }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _createAccount() {
    TextStyle defaultStyle = TextStyle(
      fontSize: 14,
      fontFamily: 'OpenSans',
      color: Color.fromRGBO(9, 5, 28, 1),
      fontWeight: FontWeight.w400,
    );
    TextStyle linkStyle = TextStyle(
      fontSize: 14,
      fontFamily: 'OpenSans',
      color: Color.fromRGBO(83, 232, 139, 1),
      fontWeight: FontWeight.w400,
    );
    return Container(
      padding: EdgeInsets.only(top: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              style: defaultStyle,
              children: <TextSpan>[
                TextSpan(text: 'Don\'t have account? '),
                TextSpan(
                    text: 'Create a new account',
                    style: linkStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacementNamed(context, 'register');
                      }),
              ],
            ),
          ),
        ],
      ),
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

  Column form(ForgotPassBloc forgotPassBloc) {
    return Column(
      children: [
        _paddingField(_emailField(forgotPassBloc)),
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

  Widget _emailField(ForgotPassBloc forgotPassBloc) {
    return TextField(
      decoration: _decorationField(
          S.of(context).login_email_field_label,
          Icon(
            Icons.email,
            color: Colors.grey,
          )),
      onChanged: (value) => {
        forgotPassBloc.changeEmail(value),
      },
      keyboardType: TextInputType.emailAddress,
    );
  }
}
