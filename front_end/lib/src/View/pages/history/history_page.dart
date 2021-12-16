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
  List<Object?> list = [];
  int _indexseleccionado = 2;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, 'home');
    }
    setState(() {
      _indexseleccionado = index;
    });
  }

  @override
  void initState() {
    loadTripHistoryfunc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //WidgetsBinding.instance!.addPostFrameCallback((_) => func());
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

  Widget body(BuildContext context) {
    return Stack(children: [
      _imageLogo(150),
      FutureBuilder(
        future: loadTripHistoryfunc(),
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.data);
          return _historyList(snapshot.data);
        },
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          bottomNavigationBar(),
        ],
      ),
    ]);
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

  Future<List<Trip>> loadTripHistoryfunc() async {
    List tmpList = [];
    List<Trip> listTrip = [];
    tmpList = await Auth.getTripHistory('YXQqAv9QOTbtzhzSk3wz');

    for (Object? i in tmpList) {
      listTrip.add(Trip.fromJson(i as Map));
    }
    //print(listTrip);

    return listTrip;
  }

  ListView _historyList(List<dynamic> data) {
    return ListView.builder(
      itemCount: data.length, //Tamaño de la lista

      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            borderOnForeground: true,
            elevation: 5.0,
            shadowColor: Color.fromRGBO(83, 232, 139, 1),
            //color: Color.fromRGBO(83, 232, 139, 0.9),
            child: ListTile(
              title: Row(
                children: [
                  Text('Conductor: ' + data[index].driverId),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Origen: ' + index.toString() + ' Destino: ' + index.toString()),
                  Text('Carro: ' + data[index].car),
                  Text('Fecha:' + data[index].date.toDate().toString()),
                  SizedBox(
                    height: 10,
                  ),
                ],
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
              onTap: () {
                Navigator.pushReplacementNamed(context, 'travelHistoryDetail');
              },
            ),
          ),
        );
      },
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Historial de viajes'),
        //Navigator.pushReplacementNamed(context, 'tripHistory');
        BottomNavigationBarItem(icon: Icon(Icons.message_rounded), label: 'Mensajes')
      ],
      currentIndex: _indexseleccionado,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
    );
  }
}
