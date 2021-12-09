import 'dart:io';
import 'package:front_end/src/Logic/validators/registerValidator.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with RegisterValidator {
  final _isDriverControler = BehaviorSubject<bool>();
  final _nameControler = BehaviorSubject<String>();
  final _emailControler = BehaviorSubject<String>();
  final _phoneNumberControler = BehaviorSubject<String>();
  final _passwordControler = BehaviorSubject<String>();
  final _confirmPasswordControler = BehaviorSubject<String>();
  final _plateControler = BehaviorSubject<String>();
  final _colorControler = BehaviorSubject<String>();
  final _modelControler = BehaviorSubject<String>();
  final _imageControler = BehaviorSubject<File>();

  Stream<bool> get isDriverStream => _isDriverControler.stream;
  Stream<String> get nameStream => _nameControler.stream.transform(validateEmpty);
  Stream<String> get emailStream => _emailControler.stream.transform(validateEmail);
  Stream<String> get phoneNumberStream => _phoneNumberControler.stream.transform(validateEmpty);
  Stream<String> get passwordStream => _passwordControler.stream.transform(validatePassword);
  Stream<String> get confirmPasswordStream => _confirmPasswordControler.stream.transform(validatePassword);
  Stream<String> get plateStream => _plateControler.stream.transform(validateEmpty);
  Stream<String> get colorStream => _colorControler.stream.transform(validateEmpty);
  Stream<String> get modelStream => _modelControler.stream.transform(validateEmpty);
  Stream<File> get imageStream => _imageControler.stream;
  Stream<bool> get validateBasicForm => Rx.combineLatest5(nameStream, emailStream, phoneNumberStream, passwordStream, confirmPasswordStream, (a, b, c, d, e) => true);
  Stream<bool> get validateCompleteForm => Rx.combineLatest8(nameStream, emailStream, phoneNumberStream, passwordStream, confirmPasswordStream, plateStream, colorStream, modelStream, (a, b, c, d, e, f, g, h) => true);

  Function(bool) get changeIsDriver => _isDriverControler.sink.add;
  Function(String) get changeName => _nameControler.sink.add;
  Function(String) get changeEmail => _emailControler.sink.add;
  Function(String) get changePhoneNumber => _phoneNumberControler.sink.add;
  Function(String) get changePassword => _passwordControler.sink.add;
  Function(String) get changeConfirmPassword => _confirmPasswordControler.sink.add;
  Function(String) get changePlate => _plateControler.sink.add;
  Function(String) get changeColor => _colorControler.sink.add;
  Function(String) get changeModel => _modelControler.sink.add;
  Function(File) get changeImage => _imageControler.sink.add;

  bool? get isDriver => _isDriverControler.valueOrNull;
  String? get name => _nameControler.valueOrNull;
  String? get email => _emailControler.valueOrNull;
  String? get phoneNumber => _phoneNumberControler.valueOrNull;
  String? get password => _passwordControler.valueOrNull;
  String? get confirmPassword => _confirmPasswordControler.valueOrNull;
  String? get plate => _plateControler.valueOrNull;
  String? get color => _colorControler.valueOrNull;
  String? get model => _modelControler.valueOrNull;
  File? get image => _imageControler.valueOrNull;

  dispose() {
    _isDriverControler.close();
    _nameControler.close();
    _emailControler.close();
    _phoneNumberControler.close();
    _passwordControler.close();
    _confirmPasswordControler.close();
    _plateControler.close();
    _colorControler.close();
    _modelControler.close();
    _imageControler.close();
  }
}
