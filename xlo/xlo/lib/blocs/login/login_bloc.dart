import 'package:rxdart/rxdart.dart';
import 'package:xlo/blocs/login/field_state.dart';
import 'package:xlo/blocs/login/login_bloc_state.dart';
import 'package:xlo/validators/login_validators.dart';

class LoginBloc with LoginValidator {

  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();
  final BehaviorSubject<LoginBlocState> _stateController = BehaviorSubject<LoginBlocState>.seeded(LoginBlocState(LoginState.IDLE));

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<FieldState> get outEmail => _emailController.stream.transform(emailValidator);
  Stream<FieldState> get outPassword => _passwordController.stream.transform(passwordValidator);

  Stream<LoginBlocState> get outState => _stateController.stream;

  void dispose() {
    _emailController.close();
    _passwordController.close();
    _stateController.close();
  }

}