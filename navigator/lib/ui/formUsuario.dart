import 'package:flutter/material.dart';
import 'package:navegacion/data/usuario.dart';
import 'package:sqflite/sqlite_api.dart';
import '../main.dart';

class FormUsuario extends StatefulWidget {
  //Conexión a BD
  final Future<Database> database;
  //Ventana principal que repintaremos una vez se registre el usuario
  final MyHomePageState homePage;
  FormUsuario(this.database, this.homePage);
  @override
  _FormUsuarioState createState() => _FormUsuarioState();
}

class _FormUsuarioState extends State<FormUsuario> {
  //Llave del formulario
  final _formKey = GlobalKey<FormState>();
  //Usuario a registrar
  final _usuario = Usuario();
  @override
  void initState() {
    super.initState();
    //Si el usuario no es nulo, quiere decir que el formulario está en modo de
    //edición. Para ello, pasamos los datos del usuario de la aplicación
    //(widget.homePage.user) al usuario que utiliza este formulario (_usuario)
    if (widget.homePage.user != null) {
      _usuario.id = widget.homePage.user.id;
      _usuario.nombre = widget.homePage.user.nombre;
      _usuario.email = widget.homePage.user.email;
      _usuario.clave = widget.homePage.user.clave;
    }
  }

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
      _txtNombre(),
      Divider(height: 20, color: Colors.white),
      _txtEmail(),
      Divider(height: 20, color: Colors.white),
      _txtClave(),
      Divider(height: 60, color: Colors.white),
      Align(
        alignment: Alignment.bottomRight,
        widthFactor: 4,
        child: botonGuardar(),
      )
    ]);
  }

  RaisedButton botonGuardar() {
    return RaisedButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          //Si los campos del formulario están validados correctamente, se procede a
          //llamar a la función save(), lo que hace es llamar a la parte onSave de
          //cada campo del formulario
          _formKey.currentState.save();
          //Para la función de sesiones, hacemos que su sesión tenga el valor de true
          //(sesión iniciada) y luego registramos el usuario en la BD
          _usuario.sesion = true;
          //Registramos el usuario en la BD
          _usuario.registra(widget.database);
          //Repintamos la ventana inicial para que detecte que hay un usuario y ahora
          //despliegue la ventana de bienvenida
          widget.homePage.repintaConUsuario();
          //Cuando estamos editando el usuario (su id es mayor a cero) desplegaremos
          //un mensaje de tipo SnackBar indicando que los datos han sido guardados
          if (_usuario.id > 0) {
            Navigator.of(context).pop();
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Datos guardados'),
            ));
          }
        }
      },
      child: Text('Guardar',
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

  //Campo de nombre
  TextFormField _txtNombre() => TextFormField(
        initialValue: _usuario.nombre,
        decoration: InputDecoration(
          labelText: 'Nombre',
          labelStyle: TextStyle(fontSize: 20),
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          hintText: 'Nombre completo',
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "El campo de nombre está vacío.";
          }
          return null;
        },
        onSaved: (value) => setState(() => _usuario.nombre = value),
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
