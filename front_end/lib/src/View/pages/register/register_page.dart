import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_end/generated/l10n.dart';
import 'package:front_end/src/Logic/bloc/registerBloc.dart';
import 'package:front_end/src/Logic/provider/ProvidetBlocs.dart';

import 'package:front_end/src/Logic/utils/auth_utils.dart';
import 'package:front_end/src/View/widgets/shared/utils/button_widget.dart';
import 'package:provider/src/provider.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    RegisterBloc registerBloc = context.read<ProviderBlocs>().register;
    if (registerBloc.isDriver == null) {
      registerBloc.changeIsDriver(false);
    }

    return WillPopScope(
      onWillPop: () {
        return Navigator.maybePop(context);
      },
      child: Scaffold(
        body: body(context, registerBloc),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ButtomWidget(
            stream: registerBloc.validateBasicForm,
            //stream: null,
            function: () => {
              Auth.signUp(context, email: registerBloc.email!, password: registerBloc.password!),
              Navigator.pushReplacementNamed(context, 'register/foto'),
            },
            text: S.of(context).continue_label,
            enebleColor: Color.fromRGBO(83, 232, 139, 1),
            disableColor: Colors.grey[400]!,
          ),
        ),
      ),
    );
  }

  Stack body(BuildContext context, RegisterBloc registerBloc) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/img/App_icon.svg',
                    fit: BoxFit.cover,
                    //semanticsLabel: 'apksnd',
                    //color: Colors.blue,
                  ),
                ),
              ),
              Container(
                child: Text(
                  S.of(context).register_title,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'OpenSans',
                    color: Color.fromRGBO(9, 5, 28, 1),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    return form(registerBloc);
                  })
            ],
          ),
        )
      ],
    );
  }

  Column form(RegisterBloc registerBloc) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: TextField(
            decoration: InputDecoration(
              //hintText: "Your Name",
              labelText: S.of(context).name,
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
                Icons.person,
                color: Colors.grey,
              ),
            ),
            onChanged: (value) => {
              registerBloc.changeName(value),
            },
            obscureText: false,
            //maxLength: 20,
          ),
        ),
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
              registerBloc.changeEmail(value),
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
              registerBloc.changePhoneNumber(value),
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
              registerBloc.changePassword(value),
            },
            obscureText: true,
            //maxLength: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: TextField(
            decoration: InputDecoration(
              //hintText: "Your Name",
              labelText: "Confirmar Contraseña",
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
              registerBloc.changeConfirmPassword(value),
            },
            obscureText: true,
            //maxLength: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: registerBloc.isDriver,
                onChanged: (value) => {
                  setState(
                    () {
                      registerBloc.changeIsDriver(value ?? false);
                    },
                  ),
                },
              ),
              Text('Se registra como Como Conducor?'),
            ],
          ),
        ),
        registerBloc.isDriver != null && registerBloc.isDriver == true
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        //hintText: "Your Name",
                        labelText: "Placa",
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
                          Icons.calendar_view_day,
                          color: Colors.grey,
                        ),

                        //icon: Icon(Icons.person),
                      ),
                      obscureText: false,
                      //maxLength: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        //hintText: "Your Name",
                        labelText: "Color",
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
                          Icons.format_color_fill,
                          color: Colors.grey,
                        ),

                        //icon: Icon(Icons.person),
                      ),
                      obscureText: false,
                      //maxLength: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        //hintText: "Your Name",
                        labelText: "Modelo",
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
                          Icons.time_to_leave,
                          color: Colors.grey,
                        ),

                        //icon: Icon(Icons.person),
                      ),
                      obscureText: false,
                      //maxLength: 20,
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
