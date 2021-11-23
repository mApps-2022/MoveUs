import 'package:front_end/src/Logic/validators/LoginValidator.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with LoginValidator {
  final _emailControler = BehaviorSubject<String>();
  final _phoneNumberControler = BehaviorSubject<String>();
  final _passwordControler = BehaviorSubject<String>();

  Stream<String> get emailStream => _emailControler.stream.transform(validateEmail);
  Stream<String> get phoneNumberStream => _phoneNumberControler.stream;
  Stream<String> get passwordStream => _passwordControler.stream;
  Stream<bool> get validateBasicForm => Rx.combineLatest3(emailStream, phoneNumberStream, passwordStream, (a, b, c) => true);

  Function(String) get changeEmail => _emailControler.sink.add;
  Function(String) get changePhoneNumber => _phoneNumberControler.sink.add;
  Function(String) get changePassword => _passwordControler.sink.add;

  String? get email => _emailControler.valueOrNull;
  String? get phoneNumber => _phoneNumberControler.valueOrNull;
  String? get password => _passwordControler.valueOrNull;

  dispose() {
    _emailControler.close();
    _phoneNumberControler.close();
    _passwordControler.close();
  }
}
