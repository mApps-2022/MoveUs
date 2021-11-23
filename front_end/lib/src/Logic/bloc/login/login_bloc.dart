import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end/src/Logic/utils/form_submission_status.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;

  LoginBloc({required this.authRepo}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // Username updated
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username);

      // Password updated
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);

      // Form submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        await authRepo.login();
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed());
      }
    }
  }
}

class AuthRepository {
  Future<void> login() async {
    print('attempting login');
    await Future.delayed(Duration(seconds: 3));
    print('logged in');
    throw Exception('failed log in');
  }
}