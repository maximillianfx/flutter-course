import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

  @observable
  bool visiblePassword = false;

  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  bool loading = false;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void setPasswordVisibility() => visiblePassword = !visiblePassword;

  @computed
  bool get isEmailValid => email.length > 6;

  @computed
  bool get isPasswordValid => password.length > 6;

  @action
  Future<void> login() async {
    loading = true;

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    loggedIn = true;
  }

  @action
  void logout() {
    email = "";
    password = "";
    loggedIn = false;
  }

  @computed
  Function get loginPressed => (isEmailValid && isPasswordValid && !loading) ? login : null;

  @computed
  bool get isPasswordVisible => visiblePassword;

  @observable
  bool loggedIn = false;

}