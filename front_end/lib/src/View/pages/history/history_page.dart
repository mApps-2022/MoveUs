// ignore_for_file: argument_type_not_assignable_to_error_handler

import 'package:flutter/material.dart';
import 'package:front_end/src/Logic/models/tripInfo.dart';
import 'package:front_end/src/Logic/utils/auth_utils.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final temp = ['viaje 1', 'viaje 2', 'viaje 3', 'viaje 4'];
  List<Object?> tripHistoryList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      tripHistoryList = await Auth.getTripHistory('YXQqAv9QOTbtzhzSk3wz');
    });

    return WillPopScope(
      onWillPop: () {
        return Navigator.maybePop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Historial de viajes'),
        ),
        body: body(context),
      ),
    );
  }

  Stack body(BuildContext context) {
    return Stack(
      children: [
        _imageLogo(150),
        _historyList(),
      ],
    );
  }

  Container _imageLogo(double imageHeight) {
    return Container(
      padding: EdgeInsets.only(top: 50),
      child: Center(
        child: Image.asset(
          'assets/img/logo.png',
          height: imageHeight,
        ),
      ),
    );
  }

  ListView _historyList() {
    // = await Auth.signUp(context, email: registerBloc.email!, displayName: registerBloc.name, password: registerBloc.password!);
    //Map decodedTripHistoryList = json.decode(tripHistoryList);
    //List<Object?> tripHistoryList = await Auth.getTripHistory('YXQqAv9QOTbtzhzSk3wz');
    //Trip listTrip = tripHistoryList.fromJson(data.snapshot.value as Map);
    //Posiciones posicionesDb = Posiciones.fromJson(data.snapshot.value as Map);

    return ListView.builder(
      itemCount: 10, //Tamaño de la lista

      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            borderOnForeground: true,
            elevation: 5.0,
            shadowColor: Color.fromRGBO(83, 232, 139, 1),
            //color: Color.fromRGBO(83, 232, 139, 0.9),
            child: ListTile(
              title: Text('data a: $index'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Origen: ' + index.toString() + ' Destino: ' + index.toString()), Text('data')],
              ),
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 64,
                ),
                child: Image.asset('assets/img/Photo.png', fit: BoxFit.cover),
              ),

              //FlutterLogo(size: 72.0), onTap: () {},
            ),
          ),
        );
      },
    );
  }
}
