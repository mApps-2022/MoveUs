import 'package:front_end/src/Logic/validators/ForgotPassValidator.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPassBloc with ForgotPassValidator {
  final _emailControler = BehaviorSubject<String>();

  Stream<String> get emailStream => _emailControler.stream.transform(validateEmail);
  //Rx.combineLatest(emailStream, emailStream => true);

  Function(String) get changeEmail => _emailControler.sink.add;

  String? get email => _emailControler.valueOrNull;

  dispose() {
    _emailControler.close();
  }
}
