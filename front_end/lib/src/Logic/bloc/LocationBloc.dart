import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';

class LocationBloc {
  final _currentlocControler = BehaviorSubject<LocationData>();


  Stream<LocationData> get currentlocStream => _currentlocControler.stream;


  Function(LocationData) get changeCurrentloc => _currentlocControler.sink.add;


  LocationData? get currentloc => _currentlocControler.valueOrNull;


  dispose() {
    _currentlocControler.close();
  }
}