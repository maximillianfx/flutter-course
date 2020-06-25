import 'package:flutter/material.dart';
import 'package:xlo/blocs/signup_bloc.dart';
import 'package:xlo/screens/signup/widgets/field_title.dart';
import 'package:xlo/screens/signup/widgets/password_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignUpBloc _signUpBloc;

  @override
  void initState() {
    super.initState();
    _signUpBloc = SignUpBloc();
  }

  @override
  void dispose() {
    _signUpBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Cadastrar"),
      ),
      body: Form(
        key: _formKey,
        child: StreamBuilder<SignUpBlocState>(
          stream: _signUpBloc.outState,
          initialData: SignUpBlocState(SignUpState.IDLE),
          builder: (context, snapshot) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: <Widget>[
                const FieldTitle(title: "Apelido",subTitle: "Como aparecerá em seus anúncios",),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 15),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Exemplo: Joao S."
                    ),
                    validator: (text) {
                      if (text.length < 6) {
                        return "Apelido muito curto";
                      }
                      return null;
                    },
                    onSaved: _signUpBloc.setName,
                    enabled: snapshot.data.state != SignUpState.LOADING,
                  ),
                ),
                const FieldTitle(title: "E-mail",subTitle: "Enviaremos um e-mail de confirmação",),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 15),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                    ),
                    validator: (text) {
                      if (text.length < 6 || !text.contains('@')) {
                        return "E-mail inválido";
                      }
                      return null;
                    },
                    onSaved: _signUpBloc.setEmail,
                    enabled: snapshot.data.state != SignUpState.LOADING,
                  ),
                ),
                const FieldTitle(title: "Senha",subTitle: "Use letras, números e caracteres especiais",),
                PasswordField(
                  onSaved: _signUpBloc.setPassword,
                  enabled: snapshot.data.state != SignUpState.LOADING,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  height: 50,
                  child: RaisedButton(
                    color: Colors.pink,
                    disabledColor: Colors.pink.withAlpha(150),
                    child: snapshot.data.state != SignUpState.LOADING ? Text(
                      "Cadastre-se",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),
                    ) : CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                    ),
                    onPressed: snapshot.data.state != SignUpState.LOADING ? _signUp : null,
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Já tem uma conta?",
                        style: TextStyle(
                          fontSize: 16
                        ),
                      ),
                      SizedBox(width: 5,),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Entrar",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                            fontSize: 16
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }

  void _signUp() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _signUpBloc.signUp();
    }
  }
}
