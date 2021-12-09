import 'package:front_end/src/Logic/bloc/registerBloc.dart';

class RegisterLogic {
  cleanRegisterBolc(RegisterBloc registerBloc) {
    registerBloc.changeIsDriver(false);
    registerBloc.changeName('');
    registerBloc.changeEmail('');
    registerBloc.changePhoneNumber('');
    registerBloc.changePassword('');
    registerBloc.changeConfirmPassword('');
    registerBloc.changePlate('');
    registerBloc.changeColor('');
    registerBloc.changeModel('');
  }
}
