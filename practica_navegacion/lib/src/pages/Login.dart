import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _ctrCorreo = TextEditingController();
  final _ctrPass = TextEditingController();
  final usuario = "Javier";
  final pass = "1234";

  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text('Login')),
        body: Form(
            key: _formKey,
            child: ListView(
              children: [_campoCorreeo(), _campoPass(), _campoBoton(context)],
            )));
  }

  Widget _campoCorreeo() {
    return TextFormField(
      controller: _ctrCorreo,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _campoPass() {
    return TextFormField(
      controller: _ctrPass,
      obscureText: true,
    );
  }

  Widget _campoBoton(context) {
    return RaisedButton(
        child: Text('Ingresar'),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            if (_ctrCorreo.text == usuario && _ctrPass.text == pass) {
              Navigator.pushReplacementNamed(context, '/home');
            } else {
              _scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text('Datos Incorrectos [Escribe bien]')));
            }
          }
        });
  }
}
