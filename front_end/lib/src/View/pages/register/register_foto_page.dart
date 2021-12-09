import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:front_end/src/Logic/bloc/registerBloc.dart';
import 'package:front_end/src/Logic/provider/ProviderBlocs.dart';
import 'package:front_end/src/View/pages/register/register_logic.dart';

import 'package:front_end/src/View/widgets/shared/utils/button_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/src/provider.dart';

class RegisteFotoPage extends StatefulWidget {
  RegisteFotoPage({Key? key}) : super(key: key);

  @override
  _RegisteFotoPageState createState() => _RegisteFotoPageState();
}

class _RegisteFotoPageState extends State<RegisteFotoPage> {
  late RegisterBloc registerBloc;
  File auxFile = new File('');
  RegisterLogic registerLogic = RegisterLogic();
  @override
  Widget build(BuildContext context) {
    registerBloc = context.read<ProviderBlocs>().register;
    if (registerBloc.image == null) {
      registerBloc.changeImage(auxFile);
    }
    return WillPopScope(
      onWillPop: () {
        return Navigator.maybePop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              registerLogic.cleanRegisterBolc(registerBloc);
              Navigator.pushReplacementNamed(context, 'register');
            },
            child: Icon(
              Icons.arrow_back_ios_new, // add custom icons also
            ),
          ),
          backgroundColor: Colors.white54,
          elevation: 2,
        ),
        body: body(context),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ButtomWidget(
            stream: null,
            function: () => registerBloc.image!.path == '' ? dialogPhoto() : dialogConfirmPhoto(),
            text: registerBloc.image!.path == '' ? 'añadir foto' : 'quiere selecionar esta foto',
            enebleColor: Color.fromRGBO(83, 232, 139, 1),
            disableColor: Colors.grey[400]!,
          ),
        ),
      ),
    );
  }

  uploadPhoto(bool isCamera) async {
    try {
      final ImagePicker _picker = ImagePicker();
      final image = await _picker.pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        registerBloc.changeImage(imageTemporary);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  dialogPhoto() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Eliga la foto'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  uploadPhoto(false);
                  Navigator.pop(context);
                },
                child: Text('elegir de galeria'),
              ),
              TextButton(
                onPressed: () {
                  uploadPhoto(true);
                  Navigator.pop(context);
                },
                child: Text('tomar con camara'),
              ),
            ],
          );
        });
  }

  dialogConfirmPhoto() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Eliga la foto'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  registerLogic.cleanRegisterBolc(registerBloc);
                  registerBloc.changeImage(auxFile);
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Text('elegir esta foto'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    registerBloc.changeImage(auxFile);
                  });
                },
                child: Text('elegir otra foto'),
              ),
            ],
          );
        });
  }

  body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Text('Eliga su foto de perfil'),
        ),
        SizedBox(
          height: size.height / 8,
        ),
        Container(
          child: Center(
            child: registerBloc.image!.path == ''
                ? Image(
                    image: AssetImage('assets/img/Photo.png'),
                  )
                : Image.file(
                    registerBloc.image!,
                    width: size.width / 2,
                    height: size.height / 2,
                  ),
          ),
        ),
      ],
    );
  }
}
