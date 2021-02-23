import 'package:sqflite/sqflite.dart';

class Usuario {
  int id;
  String nombre;
  String email;
  String clave;
  bool sesion;
  Usuario({this.id, this.nombre, this.email, this.clave, this.sesion});
  //Función que asigna los datos de este usuario
  //a los datos correspondientes en la BD
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre.trim(),
      'email': email.trim(),
      'clave': clave.trim(),
      'sesion': sesion
    };
  }

  //Función que registra a este usuario en la BD
  Future<void> registra(Future<Database> db) async {
    final Database database = await db;
    await database.insert('usuario', toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Función que obtiene el usuario registrado en la BD
  static Future<Usuario> leeBD(Future<Database> db) async {
    final Database database = await db;
    //Ejecuta el query SELECT * FROM usuario
    List<Map<String, dynamic>> lista = await database.query('usuario');
    List<Usuario> usuarios = List.generate(lista.length, (i) {
      return Usuario(
        id: lista[i]['id'],
        nombre: lista[i]['nombre'],
        email: lista[i]['email'],
        clave: lista[i]['clave'],
        //Como en SQLITE no existen los boolean, se guardan INT entonces verificamos
        //que si el valor en BD es 1, el campo sesion toma el valor de true,
        //de lo contrario false
        sesion: lista[i]['sesion'] == 1,
      );
    });

    //Si existe algún usuario, regresa el primero que encuentre
    //(debe ser el único existente). Si no existen usuarios,
    //regresa null.
    return usuarios.length > 0 ? usuarios.elementAt(0) : null;
  }

  //Función que verifica si un usuario existe en la BD
  static Future<Usuario> verificaBD(
      String uCorreo, String uClave, Future<Database> db) async {
    final Database database = await db;
    //Ejecuta el query SELECT * FROM usuario WHERE email=uCorreo AND clave=uClave
    List<Map<String, dynamic>> lista = await database.query('usuario',
        where: 'email=\"' + uCorreo + '\" AND clave=\"' + uClave + '\"');
    List<Usuario> usuarios = List.generate(lista.length, (i) {
      return Usuario(
        id: lista[i]['id'],
        nombre: lista[i]['nombre'],
        email: lista[i]['email'],
        clave: lista[i]['clave'],
        sesion: lista[i]['sesion'] == 1,
      );
    });

    //Si existe algún usuario, regresa el primero que encuentre
    //(debe ser el único existente). Si no existen usuarios,
    //regresa null.
    return usuarios.length > 0 ? usuarios.elementAt(0) : null;
  }
}
