import 'package:front_end/src/Logic/validators/LoginValidator.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with LoginValidator {
  final _emailControler = BehaviorSubject<String>();
  final _phoneNumberControler = BehaviorSubject<String>();
  final _passwordControler = BehaviorSubject<String>();
  final _userState = BehaviorSubject<String>();

  Stream<String> get emailStream => _emailControler.stream.transform(validateEmail);
  Stream<String> get phoneNumberStream => _phoneNumberControler.stream;
  Stream<String> get passwordStream => _passwordControler.stream.transform(validatePassword);
  Stream<String> get userStateStream => _userState.stream;
  Stream<bool> get validateBasicForm => Rx.combineLatest2(emailStream, passwordStream, (a, b) => true);

  Function(String) get changeEmail => _emailControler.sink.add;
  Function(String) get changePhoneNumber => _phoneNumberControler.sink.add;
  Function(String) get changePassword => _passwordControler.sink.add;
  Function(String) get changeUserState => _userState.sink.add;

  String? get email => _emailControler.valueOrNull;
  String? get phoneNumber => _phoneNumberControler.valueOrNull;
  String? get password => _passwordControler.valueOrNull;
  String? get userState => _userState.valueOrNull;

  dispose() {
    _emailControler.close();
    _phoneNumberControler.close();
    _passwordControler.close();
  }
}
