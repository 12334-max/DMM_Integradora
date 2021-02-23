import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _ctrCorreo = TextEditingController();
  final _ctrPass = TextEditingController();
  final usuario = 'Javi';
  final pass = '1808';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Form(
          key: _formkey,
          child: ListView(
            children: [_campoCorreo(), _campoPass(), _campoBoton(context)],
          ),
        ));
  }

  Widget _campoCorreo() {
    return TextField(
      controller: _ctrCorreo,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon(Icons.verified_user),
      ),
    );
  }

  Widget _campoPass() {
    return TextField(
      controller: _ctrPass,
      obscureText: true,
      decoration: InputDecoration(
        icon: Icon(Icons.vpn_key),
      ),
    );
  }

  Widget _campoBoton(context) {
    return RaisedButton(
      color: Colors.deepPurpleAccent[100],
      child: Text('Ingresar'),
      onPressed: () {
        if (_formkey.currentState.validate()) {
          if (_ctrCorreo.text == usuario && _ctrPass.text == pass) {
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Datos incorrectos'),
            ));
          }
        }
      },
    );
  }
}
