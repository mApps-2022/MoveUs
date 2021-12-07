import 'package:flutter/material.dart';

import 'package:front_end/src/Logic/bloc/registerBloc.dart';
import 'package:front_end/src/Logic/provider/ProviderBlocs.dart';

import 'package:front_end/src/View/widgets/shared/utils/button_widget.dart';
import 'package:provider/src/provider.dart';

class RegisteFotoPage extends StatefulWidget {
  RegisteFotoPage({Key? key}) : super(key: key);

  @override
  _RegisteFotoPageState createState() => _RegisteFotoPageState();
}

class _RegisteFotoPageState extends State<RegisteFotoPage> {
  @override
  Widget build(BuildContext context) {
    RegisterBloc registerBloc = context.read<ProviderBlocs>().register;
    return WillPopScope(
      onWillPop: () {
        return Navigator.maybePop(context);
      },
      child: Scaffold(
        body: body(context, registerBloc),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ButtomWidget(
            stream: null,
            function: () => print('object'),
            text: 'añadir foto',
            enebleColor: Color.fromRGBO(83, 232, 139, 1),
            disableColor: Colors.grey[400]!,
          ),
        ),
      ),
    );
  }

  body(BuildContext context, registerBloc) {
    return Column(
      children: [
        Container(
          child: Center(
            child: Image(
              image: AssetImage('assets/img/Photo.png'),
            ),
          ),
        ),
      ],
    );
  }
}
