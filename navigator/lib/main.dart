import 'package:flutter/material.dart';
import 'package:navegacion/data/db.dart';
import 'package:navegacion/data/usuario.dart';
import 'package:navegacion/ui/formLogin.dart';
import 'package:navegacion/ui/formUsuario.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(title: 'Mi App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  //Nuestro manejador de BD
  DBManager db;
  //El usuario de esta App
  Usuario user;
  //La lectura desde BD es asíncrona, por lo tanto puede suceder que se
  //tome unos segundos antes de terminar de leer. La variable loading
  //indica si todavía se está leyendo desde BD o no.
  bool loading = true;
  @override
  void initState() {
    super.initState();
    //Al inicializar esta ventana, primero realizamos la conexión a BD
    //y buscamos un usuario registrado
    db = DBManager();
    Usuario.leeBD(db.getConnection()).then((Usuario u) {
      //Usuario.leeBD busca un usuario registrado
      //Al hacer .then indicamos que una vez termine de leer de BD
      //realice las siguientes acciones
      user = u; //Guardamos el usuario leído en la variable user
      loading = false; //Indicamos que se terminó de leer
      repinta(); //Repintamos esta ventana
    }, onError: (error) {
      //En caso de error, marcamos el usuario como null
      user = null;
      loading = false;
      repinta();
    });
  }

  //Función que repinta esta ventana
  repinta() {
    setState(() {});
  }

  //Busca un usuario registrado en la BD y repinta la ventana
  repintaConUsuario() {
    Usuario.leeBD(db.getConnection()).then((Usuario u) {
      user = u;
      loading = false;
      repinta();
    }, onError: (error) {
      user = null;
      loading = false;
      repinta();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _body(),
      //Si existe un usuario y está iniciada su sesión agregamos el menú,
      //si no dejamos el menú en null
      drawer: user != null && user.sesion ? _menu() : null,
    );
  }

  Widget _body() {
    if (loading) {
      //Si todavía se están leyendo datos desde BD se muestra un indicador de
      //progreso
      return Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CircularProgressIndicator(
          value: null,
        ),
        Divider(
          color: Colors.white,
        ),
        Text('Cargando Datos')
      ]));
    } else {
      if (user == null) {
        //Si no existe un usuario registrado, se mostrará la ventana de registro.
        //Al formulario se le pasan dos argumentos: la conexión a BD y esta ventana
        //de tipo MyHomePageState, representada por this
        return FormUsuario(db.getConnection(), this);
      } else {
        //entonces se muestra la ventana de bienvenida, de lo contrario
        //se presenta la ventana de inicio de sesión
        if (user.sesion) {
          return Center(
            child: Text(
              'Bote de bausra llena ' + user.nombre,
              style: TextStyle(fontSize: 20),
            ),
          );
        } else {
          return FormLogin(db.getConnection(), this);
        }
      }
    }
  }

  Drawer _menu() => Drawer(
        child: DrawerHeader(
            decoration: BoxDecoration(color: Colors.cyan),
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.bookmark_border, color: Colors.white),
                  title: Text('Mi App',
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                  onTap: () => Navigator.of(context).pop(),
                ),
                Divider(color: Colors.white, thickness: 2),
                ListTile(
                  leading: Icon(Icons.person_outline, color: Colors.white),
                  //Si el usuario no es null, mostramos su nombre, si no
                  //significa que aún se está leyendo desde la BD
                  title: Text(user != null ? user.nombre : "Cargando...",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).pop();
                    //Desplegamos la ventana del formulario
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text(widget.title),
                          ),
                          body: FormUsuario(db.getConnection(), this),
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.android, color: Colors.white),
                  title: Text("S_Ultrasónico",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.android, color: Colors.white),
                  title: Text("Servo",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.android, color: Colors.blue),
                  title: Text("S_Análogo",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.android, color: Colors.white),
                  title: Text("Celda_de_carga",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app, color: Colors.white),
                  title: Text("Cerrar Sesión",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).pop();
                    //Indicamos que nuestro usuario ha cerrado sesión dando el valor false a su
                    //atributo "sesion" y guardamos ese cambio en BD, luego repintamos nuestro
                    // MyHomePageState para que en su función build detecte que no hay un usuario
                    //loggeado y presente la ventana de inicio de sesión
                    user.sesion = false;
                    user.registra(db.getConnection());
                    repinta();
                  },
                ),
              ],
            )),
      );
}
