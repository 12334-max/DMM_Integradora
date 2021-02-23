import 'package:flutter/material.dart';
import 'package:navegacion/data/usuario.dart';
import 'package:sqflite/sqlite_api.dart';
import '../main.dart';

class FormLogin extends StatefulWidget {
  //Conexión a BD
  final Future<Database> database;
  //Ventana principal que repintaremos una vez inicie sesión el usuario
  final MyHomePageState homePage;
  FormLogin(this.database, this.homePage);
  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  //Llave del formulario
  final _formKey = GlobalKey<FormState>();
  //Usuario a validar
  final _usuario = Usuario();
  @override
  Widget build(BuildContext context) {
    //Usamos SingleChildScrollView para permitir que el usuario navegue
    //hacia arriba o abajo del formulario en pantallas pequeñas
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          //El padding sirve para dejar un espacio lateral de 20px
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: columnaCampos(),
        ),
      ),
    );
  }

  //Los campos del formulario están dentro de un Column
  Column columnaCampos() {
    return Column(children: <Widget>[
      Divider(height: 40, color: Colors.white),
      _icono(),
      Divider(height: 20, color: Colors.white),
      _txtEmail(),
      Divider(height: 20, color: Colors.white),
      _txtClave(),
      Divider(height: 60, color: Colors.white),
      Align(
        alignment: Alignment.bottomRight,
        widthFactor: 4,
        child: botonContinuar(),
      )
    ]);
  }

  RaisedButton botonContinuar() {
    return RaisedButton(
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          //Verificamos si existe el usuario en BD
          Usuario validado = await Usuario.verificaBD(
              _usuario.email, _usuario.clave, widget.database);
          if (validado != null) {
            //Registramos en BD que la sesión ha sido iniciada
            validado.sesion = true;
            validado.registra(widget.database);
            //Repintamos la ventana inicial para que despliegue la bienvenida
            widget.homePage.repintaConUsuario();
          } else {
            //Si los datos no coinciden con el usuario registrado
            //en la BD, enviamos un mensaje
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('El correo y/o la clave no son correctos'),
            ));
          }
        }
      },
      child: Text('Continuar',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.normal)),
      color: Color(0xFF33AAAA),
    );
  }

  //Ícono que estará al principio del formulario
  Icon _icono() => Icon(
        Icons.person_outline,
        color: Colors.cyan,
        size: 100,
      );

  //Campo de correo
  TextFormField _txtEmail() => TextFormField(
        initialValue: _usuario.email,
        decoration: InputDecoration(
            labelText: 'Correo',
            labelStyle: TextStyle(fontSize: 20),
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            hintText: 'Correo electrónico'),
        //Indicamos el tipo de teclado para email
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value.isEmpty) {
            return "El campo de correo está vacío.";
          }
          return null;
        },
        onSaved: (value) => setState(() => _usuario.email = value),
      );
  //Campo de clave de usuario
  TextFormField _txtClave() => TextFormField(
        initialValue: _usuario.clave,
        decoration: InputDecoration(
            labelText: 'Clave',
            labelStyle: TextStyle(fontSize: 20),
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            hintText: 'Clave de acceso'),
        //Indicamos el tipo de teclado para contraseñas
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value.isEmpty) {
            return "El campo de clave está vacío.";
          }
          return null;
        },
        onSaved: (value) => setState(() => _usuario.clave = value),
      );
}
